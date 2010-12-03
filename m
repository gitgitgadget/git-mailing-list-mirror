From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fallback on _NSGetExecutablePath to get the executable
 path if using argv[0] fails
Date: Fri, 3 Dec 2010 01:42:59 -0600
Message-ID: <20101203074259.GB18202@burratino>
References: <051964C9-0507-4CCB-A111-55CA36652F00@apple.com>
 <AANLkTimwRJqje1-HhzKj-L-5-2CvhTC0+Pr0Cvj7d_kc@mail.gmail.com>
 <20101129171211.GL8037@burratino>
 <7534C13D-A52A-4BA4-B8C5-14E17CFA0351@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>,
	Jeremy Huddleston <jeremyhu@apple.com>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Dec 03 08:43:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POQId-0002GF-7g
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 08:43:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755694Ab0LCHnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 02:43:18 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62837 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709Ab0LCHnR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 02:43:17 -0500
Received: by gwj20 with SMTP id 20so4623219gwj.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 23:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZxjlW7lMfoWvlcvQ35eQ2fkDk4UHUxvKin0z/g67g/c=;
        b=LpbehZazUj3HQHjAxLp1DQR0T6ybcuJ13TNeuh+sFrS/H3xX9bbh1phg/Wgy4Zoore
         et+RBL6rTW2IIHL8juEhSOR6sQmyR7xkajuqkqS2mGy7Da0vv+gdN1215EvRM6Sz3ulB
         7hJgHu0c5vReBzjt24kPK5Bkt/xxs15CQ8PIA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UX3g/E/SUwxCXsGg5KlwXs0cZ7fMhLTaWUy5xQq9eT/ZuHs6vhuW5MXPfzRfF7NQeF
         TXhLCEjbL/DXHfoNQBcKVGKND5JCWaL50V1tizlV0gMHD4LoJ1PV5+sS+hK2RFv3FKC/
         tXC9qxy/8gqiwa0dOf0ifU7iSBFkI6qGKzBFI=
Received: by 10.150.204.4 with SMTP id b4mr3132440ybg.415.1291362196565;
        Thu, 02 Dec 2010 23:43:16 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id 54sm905899yhl.32.2010.12.02.23.43.12
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 23:43:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7534C13D-A52A-4BA4-B8C5-14E17CFA0351@sb.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162765>

Kevin Ballard wrote:
> On Nov 29, 2010, at 9:12 AM, Jonathan Nieder wrote:

>> The section "2) #ifdefs are ugly" of
>> linux-2.6/Documentation/SubmittingPatches explains the rationale.
>
> Might this be worth pulling into git.git/Documentation/CodingGuidelines?

Yes, the example there includes good advice I wish I had received
sooner, and Documentation/CodingGuidelines seems like a good place to
help people find it.  Do you have some wording in mind?

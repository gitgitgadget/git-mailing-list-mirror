From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git rebase and merge commits
Date: Wed, 20 Oct 2010 12:32:01 -0500
Message-ID: <20101020173201.GA10537@burratino>
References: <AANLkTikroNPehcyBsueCnJ5hR0idd3cBP4m1KNccdRqL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dominique Quatravaux <domq@google.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 19:35:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8cZt-0000Ek-Ex
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 19:35:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186Ab0JTRfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 13:35:48 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56140 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab0JTRfr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 13:35:47 -0400
Received: by vws2 with SMTP id 2so2317642vws.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=s2KAtvou5huSVxGl74hXpO8km8myUmLnn7K/l00WKZg=;
        b=gDA3XMDbgyxA8ENlwzZg5Jg8MNTVbdKqP5lHKm/4XRCRZrWhn6N+ofqKPZ5ADcRcAh
         zanXsyEorP+1NsoHnKhvwTuCm24pW7KkANaKFn9gHseuxLLzPJgnhXAsIDrlCpVAKH8r
         voXFbO4PtIsZkUcXiQLQGmjdFlfESQ4YxlnjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CtZ66riDi/VSC84ZhIuECCiA3LzP60VheYab8uFpXSJxgGec/wf1b8FiB8OSXYXg03
         TlZvU6FXkxiXN73zjpm7rmS4RVmAcgjhGOBofOxq8BspJxwzx1bB5XKqQTsglD5Wkxa/
         QYidrWLLegssNzeLGrJmtlHeUwzp+z3O2cxuQ=
Received: by 10.220.179.204 with SMTP id br12mr2245439vcb.197.1287596144905;
        Wed, 20 Oct 2010 10:35:44 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id o17sm227818vbi.2.2010.10.20.10.35.43
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 10:35:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikroNPehcyBsueCnJ5hR0idd3cBP4m1KNccdRqL@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159419>

Hi Dominique,

Dominique Quatravaux wrote:

> #        A---B---C---K targetbranch
> #       /         \
> #  D---E---F---G---H---I--J srcbranch
> 
> into this:
> 
> #   A---B---C---I'---K'  targetbranch
> #  /             \
> # D---E---F---G---H'---J' srcbranch
> #
> 
> (ie I has been shoved into targetbranch).
> 
> It seemed to me that the first step should be to simply rebase I, H, and J (in
> this order) onto C. Unfortunately git rebase --interactive -p C proposes
[...]

I'm sorry to break this news, but "rebase --interactive --preserve-merges"
(unlike "rebase --preserve-merges" without --interactive) was never
implemented completely.  See the BUGS section of the git-rebase man page.

Luckily, there is a roadmap for anyone interested in implementing it.  Maybe
it could be you?  See [1] and the surrounding thread.

Thanks for your interest,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/148059/focus=148144

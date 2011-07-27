From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 12/18] revert: Save command-line options for continuing
 operation
Date: Wed, 27 Jul 2011 16:21:16 +0200
Message-ID: <20110727142116.GB24785@elie>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-13-git-send-email-artagnon@gmail.com>
 <20110727050515.GH18470@elie>
 <CALkWK0=5drVxLe4SAVLem3cpWCB=Eg3dTFQGhLKFD+Z77RHohA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 16:21:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm4zM-0003tt-Vh
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 16:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754236Ab1G0OV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 10:21:28 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55121 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab1G0OV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 10:21:27 -0400
Received: by ewy4 with SMTP id 4so1278631ewy.19
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 07:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rG2iJxmKaCmm+IVScR9LgVTdmn5Ho36H42+L/efRfTQ=;
        b=afh/wJ4x4x3jDBm2qXGwx0Ku+pN7cstypg7AOgpQOLve0lm4Mn3TlVVC7zOSMvFtQI
         K9F7YPwtkFJnv5vUw79nfsQCeCbWFxd5I0bSb8XD+uedqAnYECnr90x7zn2mn8zz3kWY
         4k28/fAyBnuVj2fb2GaqkfpPPgHBQlAaffaU8=
Received: by 10.204.19.193 with SMTP id c1mr522819bkb.324.1311776486460;
        Wed, 27 Jul 2011 07:21:26 -0700 (PDT)
Received: from elie (adsl-165-157-240.teol.net [109.165.157.240])
        by mx.google.com with ESMTPS id q1sm1709880faa.3.2011.07.27.07.21.23
        (version=SSLv3 cipher=OTHER);
        Wed, 27 Jul 2011 07:21:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0=5drVxLe4SAVLem3cpWCB=Eg3dTFQGhLKFD+Z77RHohA@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177965>

Ramkumar Ramachandra wrote:
> Jonathan Nieder writes:

>> It would be nice if some
>> day the config parser could learn to treat dashes as insignificant,
>> just like it already treats case distinctions as insignificant.
>
> Is the documentation out of date? I can't find any special handling
> for `-` in the code either.  What are you talking about?

"It would be nice if some day the config parser could learn" implies
"The config parser does not behave like this", no?

One problem with dashes in names of real configuration variables is
that most git multi-word configuration variables are already named
using InsignificantBumpyCaps, which means the user does not have to
remember where the word breaks are as language drifts (e.g., is it a
"file name" or a "filename"?).  A convention of using dashes to
separate words would probably have been about as good, while
inconsistently sometimes using dashes and sometimes not would be far
worse.

Of course, the .git/sequencer/args file is not gitconfig, and changes
in its format are not as hard (since unlike for gitconfig, any
backward-compatibility synonyms probably do not need to be mentioned
in documentation).  So I am not too worried and this was mostly an
aside.

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: git-blame.el: does not show one-line summary in echo area
Date: Thu, 3 Feb 2011 19:43:26 -0600
Message-ID: <20110204014315.GB28525@elie>
References: <87vdgm3e1k.fsf@osv.gnss.ru>
 <m2fx7qae49.fsf@igel.home>
 <87ljhi3cao.fsf@osv.gnss.ru>
 <87fx7q4p6h.fsf@lysator.liu.se>
 <87einafojx.fsf@osv.gnss.ru>
 <87d42s3pv2.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sergei Organov <osv@javad.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org,
	Kevin Ryde <user42@zip.com.au>,
	Martin Nordholts <enselic@gmail.com>,
	Alexandre Julliard <julliard@winehq.org>,
	Xavier Maillard <zedek@gnu.org>,
	Jakub Narebski <jnareb@gmail.com>
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Fri Feb 04 02:43:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlAi5-00015A-L7
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 02:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436Ab1BDBnf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Feb 2011 20:43:35 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37509 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753951Ab1BDBne convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Feb 2011 20:43:34 -0500
Received: by ywo7 with SMTP id 7so479107ywo.19
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 17:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=JuaCrgWbglnQMRtw27ThVbT2vXVE2fUllw1Ynidgaow=;
        b=aZF4VUr+SQQuq6PdCuSMdC+UWDk+wKfmprAaxaKBGMj49saj24BaxHs6vxPdaatI7K
         rYaVdG+UFpFR3qOQFEPbRWczUsIh6GhTIfWMSod0IQVO1Bn/vGRZmOnSjofiLJ5P8dwB
         YoB09PYpbBEWhy68w/RKYF+VB/MCUG9A7zm4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=OJIahSegTm8oTKvwQWN67J5/qNmri7ijbunVNLHVGAcj9J+1xSM1YlNFFEDV2xnALK
         nL6BTg+NgwI3z6ONF1MJBFoSLsLF5/SbERlMs908yuuiShH4pmSLmf6J8rWp1XZyQsEE
         01UhWc4/qZv1VT68mM8RobitnmJKGB586okHQ=
Received: by 10.151.105.11 with SMTP id h11mr5443868ybm.231.1296783813009;
        Thu, 03 Feb 2011 17:43:33 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id w24sm706571ybk.21.2011.02.03.17.43.30
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 03 Feb 2011 17:43:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87d42s3pv2.fsf@lysator.liu.se>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166017>

Hi David et al,

David K=C3=A5gedal wrote:
> Sergei Organov <osv@javad.com> writes:

>> Now, I've evaluated (require 'format-spec) in my Emacs 22 (yes, 22, =
not
>> 23), and now git-blame almost works there. The problem I see is that=
 it
>> doesn't output anything in the echo area. It color-codes the buffer,=
 it
>> does show correct pop-up when mouse is over a region, but it doesn't
>> print anything in the echo area when I move cursor through the regio=
ns.
>> Any idea how to debug/fix this?
>
> Well, it appears I removed the output to the echo area. I didn't thin=
k
> it worked very well, and the new output format mostly replaces it by
> showing the hash.
>
> There are also technical reasons for removing it (it couldn't be
> implemented very cleanly).

I don't use git-blame.el ("git blame", "git gui blame", and "git log
-S/-G" take care of my needs already) but it seems to me that this
change was a regression.  The emacs support before v1.6.6-rc0~120^2
had a simple way to find out the purpose of each line of code, while
after that there is no simple way.  And it is what the README
promises:

 * git-blame.el:

   Emacs implementation of incremental git-blame.  When you turn it on
   while viewing a file, the editor buffer will be updated by setting
   the background of individual lines to a color that reflects which
   commit it comes from.  And when you move around the buffer, a
   one-line summary will be shown in the echo area.

Any advice for people who want to fix that?  Is anyone interested in
doing so?  (It is quite likely I am guessing incorrectly about what is
useful, but I would imagine that at least the documentation could use
updating.)

Jonathan

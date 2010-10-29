From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH resend] git-blame.el: Add (require 'format-spec)
Date: Thu, 28 Oct 2010 22:38:09 -0500
Message-ID: <20101029033809.GA30353@burratino>
References: <87vdgm3e1k.fsf@osv.gnss.ru>
 <m2fx7qae49.fsf@igel.home>
 <87ljhi3cao.fsf@osv.gnss.ru>
 <87fx7q4p6h.fsf@lysator.liu.se>
 <87einafojx.fsf@osv.gnss.ru>
 <87d42s3pv2.fsf@lysator.liu.se>
 <AANLkTikPArJ0s8BTN7QH3CeqU98BGHobKax3IrjMXPrh@mail.gmail.com>
 <87r5l0gkpc.fsf_-_@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
	Sergei Organov <osv@javad.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org,
	Kevin Ryde <user42@zip.com.au>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 05:38:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBfnM-0006UL-Sh
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 05:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758837Ab0J2DiT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Oct 2010 23:38:19 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:33103 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756277Ab0J2DiR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 23:38:17 -0400
Received: by qyk10 with SMTP id 10so2917532qyk.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 20:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=w0ocux1FFrrtAynaqCRJzDQyFsR1h0EmzjhTEdnOO5Q=;
        b=cuKbp5p+SvS2UHJBOg42/Mnwtfdyq6v6xBbVRMeo9/uW1qB7HqKrA2PH8unw0jFDNl
         KYA3QQJavKG3G+sXe2v1dz2ku1JG+BCO4xi5i2z3Mf6iRt889nzaPQGzH9z4Xt28Fi/D
         o/W2cK+zcsYliG4soCr+GCf6yeL94oR+LHvqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=AfP2Z3JFX0/+cjumGh3uWJi4rwuq/cRgNYSURBLuMDELO1okro6w1Xic2h+b1FrCC/
         VAtbjiZfvXN5HbmWT+tvmlxOuoR3ZIMCoF6bLU3efod9QrGZltC7FV7b+vLfN5aSwyks
         p5j/rTcqbJ0uML4N0ycg6rRWTia13R6Ikp/hM=
Received: by 10.229.70.204 with SMTP id e12mr144753qcj.113.1288323496957;
        Thu, 28 Oct 2010 20:38:16 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id x9sm1823613qco.46.2010.10.28.20.38.15
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 20:38:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87r5l0gkpc.fsf_-_@krank.kagedal.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160265>

Date: Tue, 25 May 2010 15:44:15 +0200
=46rom: David K=C3=A5gedal <davidk@lysator.liu.se>

c5022f57 (git-blame.el: Change how blame information is shown,
2009-09-29) taught the "M-x git-blame" mode to format its output
in a more interesting way, making use of the format-spec function.

format-spec is included in Emacs 23 and is a useful function.
Older emacsen can get it from Gnus.  In all emacsen, we need
to 'require it before use to avoid warnings:

 git-blame.el:483:1:Warning: the function `format-spec' is not known to=
 be
     defined.

Reported-by: Sergei Organov <osv@javad.com>
Reported-by: Kevin Ryde <user42@zip.com.au>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
David K=C3=A5gedal wrote:
>> On Sun, Dec 6, 2009 at 8:43 PM, David K=C3=A5gedal <davidk@lysator.l=
iu.se> wrote:
>>> Sergei Organov <osv@javad.com> writes:
>>>> Then there should be (require 'format-spec) in git-blame.el, right=
? Due
>>>> to:
>>>
>>> Of course. I must have missed that since I already had it loaded.
[...]
>                     here is the patch.

Junio, I think something like this patch is needed for git-blame.el
to work correctly.  I am no emacs lisp expert, though...

Other observations from that thread are a bit more worrying --- it
seems that c5022f57 dropped support for information about the selected
commit in the editor buffer, without updating the documentation in
contrib/emacs/README to match.

 contrib/emacs/git-blame.el |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index 7f4c792..d351cfb 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -79,6 +79,7 @@
 ;;; Code:
=20
 (eval-when-compile (require 'cl))			      ; to use `push', `pop'
+(require 'format-spec)
=20
 (defface git-blame-prefix-face
   '((((background dark)) (:foreground "gray"
--=20
1.7.0.4

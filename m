From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 18/24] merge: do not setup worktree twice
Date: Tue, 10 Nov 2009 19:58:33 -0600
Message-ID: <20091111015832.GB9027@progeny.tock>
References: <20091109150235.GA23871@progeny.tock>
 <1257779104-23884-18-git-send-email-jrnieder@gmail.com>
 <7vws1y6sxg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 02:48:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N82K7-0000V9-SA
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 02:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756460AbZKKBsY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Nov 2009 20:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756443AbZKKBsY
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 20:48:24 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:49414 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756386AbZKKBsX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 20:48:23 -0500
Received: by ywh40 with SMTP id 40so580306ywh.33
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 17:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=A7S5M9zvmEFo1GuN1lvM4WlowyFAxpglw/JL5ENKFCw=;
        b=m/6ViHa/psiyvzY/v5Q9CBZtaN4OxAdhwz2D2dBf5vO/RAlmlhNU6aLuIHgr+UmJzl
         4y9YLNwSYiQHzB3M0WzgqJf2hdZKISa2U+juMHs6eiTj+Ije1Stpc0uTM0BrlN3BUvy6
         pT6EAWx2cJWtv065pD4NXrGELvW3wI7a+umhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=WM4eaeYJGM4e17XI1YXobJnMD5mnndxtSbITAVxQX2Ql0JYOqAqm2PnQsDjER1h3Oe
         aOMuK9iVPSw4fELCOaFN3j2SbjrVXWHa6M5R2lnvzeJcjTT+7LiDHAo84W5HT4RxfEy9
         CP+d6iFLrqWMIzE4vuXjqMWecWGv1j5/UraLs=
Received: by 10.150.237.4 with SMTP id k4mr1615547ybh.93.1257904108292;
        Tue, 10 Nov 2009 17:48:28 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 14sm603336gxk.6.2009.11.10.17.48.26
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 17:48:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vws1y6sxg.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132608>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Builtins do not need to run setup_worktree() for themselves, since
>> the builtin machinery runs it for them.
>>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>> This matter since '-h' cannot suppress _this_ setup_work_tree()
>> through the builtin machinery.
>
> I think this should directly go to 'maint'.  I ejected it from the
> series.

Thanks.  I think something like this should go on top on maint, then
reverted in master.

Sorry for the trouble,
Jonathan

-- %< --
Subject: check-ref-format does not know --print yet

Don=E2=80=99t advertise the --print option of the future in the current
usage string.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin-check-ref-format.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-check-ref-format.c b/builtin-check-ref-format.c
index 96382e3..a5ba4ea 100644
--- a/builtin-check-ref-format.c
+++ b/builtin-check-ref-format.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
=20
 static const char builtin_check_ref_format_usage[] =3D
-"git check-ref-format [--print] <refname>\n"
+"git check-ref-format <refname>\n"
 "   or: git check-ref-format --branch <branchname-shorthand>";
=20
 int cmd_check_ref_format(int argc, const char **argv, const char *pref=
ix)
--=20
1.6.5.2

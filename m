From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3] shell: Rewrite documentation and improve error
 message
Date: Tue, 24 Aug 2010 18:05:27 +0530
Message-ID: <20100824123525.GA18641@kytes>
References: <1282333452-25278-1-git-send-email-artagnon@gmail.com>
 <AANLkTi=u7VUhz4VrU2hdd3SXK7rMvMrijL-X9qXCG1vs@mail.gmail.com>
 <20100822080359.GB15561@kytes>
 <AANLkTintw7=25nsr-7NjE_-xJqMab_HggjPOtSHBf109@mail.gmail.com>
 <20100824053647.GA2037@kytes>
 <AANLkTikeZTF5zZyRDtLfnPrtCYFH0WayXrJeCj8_VuC1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>
To: Greg Brockman <gdb@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Aug 24 14:37:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Onskq-0001x4-9m
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 14:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211Ab0HXMhX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 08:37:23 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48902 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab0HXMhW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 08:37:22 -0400
Received: by pwi7 with SMTP id 7so2437201pwi.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 05:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vDafTNQPozdqo1McEYIqlNJpGapLLo2lh7Wt9x5BTmw=;
        b=wnUVmiQHWFjaMI/UgQZm6RxvJNXDJ8/zp2iqDS6RX4T1SFpWW+pyQywppaFuS1+LdM
         tBEMkASt5VRIGGtg8N56EE84z8Fh7FYTnlRj8md/1j84coiD0t8tiR+Z6nEEB4EA8jpz
         TZPC9BcI6lwGNGlYrfTWsljnywKd7pJlimouU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=vLAeMUk5gjDepWP6Mg11/8KuYw7Ht2Fk41OHAyg3N0MVkEIHuoeQZLGgwlTmBIyZBS
         15QqTggNlLyIRoJAOCEIQ7uAakDMOmwzO6W4JFuIVlumxJ0oh9hoBadhH+i6ptZ0AQYJ
         MH80tXnnZQjFzx8b8d5zoT6pfP6/3d+0GxnEY=
Received: by 10.142.232.13 with SMTP id e13mr5614537wfh.133.1282653441602;
        Tue, 24 Aug 2010 05:37:21 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id v13sm58613wfv.17.2010.08.24.05.37.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 05:37:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikeZTF5zZyRDtLfnPrtCYFH0WayXrJeCj8_VuC1@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154310>

Hi Greg,

Greg Brockman writes:
> > =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"hint: ~/$C=
OMMAND_DIR should exist "
> > =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"hint: ~/" =
$COMMAND_DIR " should exist "
> There's still a floating $.  (Recall, you're in C land here, not shel=
l.)

Ugh. So sorry about this- I've been suffering from insomnia over the
last few days.

-- 8< --
diff --git a/shell.c b/shell.c
index 6aade3d..b539cdf 100644
--- a/shell.c
+++ b/shell.c
@@ -154,7 +154,7 @@ int main(int argc, char **argv)
 		cd_to_homedir();
 		if (access(COMMAND_DIR, R_OK | X_OK) =3D=3D -1) {
 			die("Interactive git shell is not enabled.\n"
-			    "hint: ~/" $COMMAND_DIR " should exist "
+			    "hint: ~/" COMMAND_DIR " should exist "
 			    "and have read and execute access.");
 		}
 		run_shell();

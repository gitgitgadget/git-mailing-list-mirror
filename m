From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git-smart-http reject push
Date: Fri, 1 Jun 2012 09:23:35 +0530
Message-ID: <CAMK1S_iAxdTg04ctZMUKAyoBRGT=w8rp2dTMDFvmpW_McPP-hQ@mail.gmail.com>
References: <4FC7D6CE.30802@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Tajti_=C3=81kos?= <akos.tajti@intland.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 05:53:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaIvm-0002Ku-1A
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 05:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758931Ab2FADxh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 23:53:37 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45662 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758487Ab2FADxg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 23:53:36 -0400
Received: by obbtb18 with SMTP id tb18so2289019obb.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 20:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=FEtuZlGIXMJIByLovw240f22Xz60JtRxH+utQMup1YM=;
        b=kNxQCkFSi/TaITmgMSB0P7Obslj/8oQIV7WKVp3PU1kZbdamT9USXsQbDIlUGmG0NG
         VP+cItI6Olpw3RFPizZypVRT21hMDBaeiMwJnVWQnLEqH4jPdOTyJalMfonYXNQHRS7n
         R1/UnMaVT4drH7hlzM1brEspLVLbaSuOCxhoUMrp0yNJVJ4yH4yEVyFCIWeVISYb4/MM
         TX6tjNGc8WJ+axgtdqTUbaoDlog15sfme42h61A0v0RkRSuZkZZjROVVGSazPEFY9jvb
         bwPMfhjZRMySW7dqCv7u8Rc+GSQW2sRUIfAn7mZ9O8kzQxSN80FYqCCt8wIzkSv6ZER4
         aWvg==
Received: by 10.60.24.165 with SMTP id v5mr958759oef.67.1338522815981; Thu, 31
 May 2012 20:53:35 -0700 (PDT)
Received: by 10.182.108.67 with HTTP; Thu, 31 May 2012 20:53:35 -0700 (PDT)
In-Reply-To: <4FC7D6CE.30802@intland.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198954>

On Fri, Jun 1, 2012 at 2:08 AM, Tajti =C3=81kos <akos.tajti@intland.com=
> wrote:
> Dear List,
>
> we wrote a servlet that is basically a proxy for git-http-backend. We=
 want
> to control who can create a new branch. Is there a way to reject a pu=
sh that
> would create a new branch (without using hooks)?

Not sure what else your servlet does or how it affects things but
gitolite has controls to prevent branches being created (among many
many other things, limited mostly by ones imagination!).

Gitolite is normally used with ssh but it has been tested with smart
http also.  It itself acts as a proxy for git-http-backend, inspecting
the URI and QUERY_STRING and such animals to decode some things, while
the rest happens via a special update hook that is installed in each
repo that it controls.

(Specifically, the branch create check is done there, not in the part
that is proxying the git-http-backend process.  You probably know that
the update hook is invoked by git itself).

Sitaram

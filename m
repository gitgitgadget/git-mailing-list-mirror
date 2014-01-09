From: Andy Lutomirski <luto@amacapital.net>
Subject: Verifiable git archives?
Date: Wed, 8 Jan 2014 19:10:32 -0800
Message-ID: <CALCETrU88evB6VQrE8=8vrc+HYXAX8_Zx7TsYZp6YXeE4dZdvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 09 04:11:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W161K-0005o0-Gj
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 04:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbaAIDKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jan 2014 22:10:54 -0500
Received: from mail-vb0-f50.google.com ([209.85.212.50]:33717 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbaAIDKx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jan 2014 22:10:53 -0500
Received: by mail-vb0-f50.google.com with SMTP id w18so1809373vbj.9
        for <git@vger.kernel.org>; Wed, 08 Jan 2014 19:10:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=m01fvrc08HI0D9wrQGpJgThRMuXWDANdQKW4STKchLM=;
        b=AjVI//ziTMAhCBpyRPyql3/vFjiDlUCglUTNrwEJErVcdX0RTDy1y/Ot/7VmkwDKW7
         bGa2dekacmw6KzzSFvAxh/Sh7t4LPCsixvnnhrdJQcBvHw0ClWVQObz/Xwm6+01sFtQG
         AcXGAmGLxm4xN2KunWO5LyCVLvoWULvxOz1QkAdGY6sKEfqdqXkVZDXdtXIhgt2JjuyV
         fQLCMlFidig9sYPN6b2dS/wdUWEZUoPvFkPtObS/F+qdrijf2AYgv6cTFbDRmhDaewy6
         onrnh1qqD1//05DTd7CQjPaEKZzUTv+d3pgAdPPVPkMmq1N/oc4ZI8Jsm5Wi3L0W4Hj9
         thyg==
X-Gm-Message-State: ALoCoQmWpoRayEFu5mMU6z4ffsJ4u19CIcRg2yrcZu6xudHdP9oz7ZA/QDqPrcvei2B1ioSL2azg
X-Received: by 10.58.211.130 with SMTP id nc2mr409993vec.7.1389237052360; Wed,
 08 Jan 2014 19:10:52 -0800 (PST)
Received: by 10.58.75.131 with HTTP; Wed, 8 Jan 2014 19:10:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240244>

It's possible, in principle, to shove enough metadata into the output
of 'git archive' to allow anyone to verify (without cloning the repo)
to verify that the archive is a correct copy of a given commit.  Would
this be considered a useful feature?

Presumably there would be a 'git untar' command that would report
failure if it fails to verify the archive contents.

This could be as simple as including copies of the commit object and
all relevant tree objects and checking all of the hashes when
untarring.

(Even better: allow subsets of the repository to be archived and
verified as well.)

--Andy

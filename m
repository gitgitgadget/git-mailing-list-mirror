From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Parse --o in format-patch
Date: Fri, 28 Jun 2013 18:05:00 +0200
Message-ID: <20130628160459.GA16832@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 28 18:05:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsbAw-00050J-7m
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 18:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755382Ab3F1QF0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jun 2013 12:05:26 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:44283 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754229Ab3F1QFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 12:05:25 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so1104541lbh.7
        for <git@vger.kernel.org>; Fri, 28 Jun 2013 09:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=dG4cZYp+J+lFSVTUoKOjaXLT0AUp14gBaNRExrWrbeU=;
        b=AslriWchqYg30gc7asKP2MLE8kWVk/qk5/QElbOXtJwUqu3weHXWs3iaU6a5+fCozb
         aCfoRXeluetA/Rg2pqLkTBRCjrRal1hnYnZbvgHnpV2LUoHf9qBgm1L870qAsgLm0lUs
         rKO/JwxcQYY/Ly2wYeWnNze5zaSQ0GYAIctXsEFpUSXggdXodkfsiqV6yoresDHVuO86
         z/jILFo0WiWaXjZbz3ijdINUyAbXw5dltz6SNgmhM6Jxa8vm1XoJ9B9hRMxlK/1RwyZs
         xWTuTh9IAMJhNf+W+NfAseVousWiicjo6mR+KLQm0EJ3EHqm7zdl34k9HCYPeuU6Qrho
         QE/g==
X-Received: by 10.152.170.138 with SMTP id am10mr6877327lac.22.1372435522672;
        Fri, 28 Jun 2013 09:05:22 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id p10sm2825196lap.8.2013.06.28.09.05.21
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 28 Jun 2013 09:05:22 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UsbAS-0005TG-0t
	for git@vger.kernel.org; Fri, 28 Jun 2013 18:05:00 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229210>

Hi,
I don't quite manage to figure out gits argv parsing and would need som=
e
help on the way.

I want:
git format-patch -o outdir HEAD~

Work exactly the way it does now, setting output_directory to outdir.
But I also want
git format-patch -o HEAD~

to set output_directory with a NULL value so that I can assign a defaul=
t
value to it. Is that even possible with the current argv-parsing implem=
entation?

The currect argv parser is using OPTION_CALLBACK so I thought that that
callback should be able to determine if there was an outdir supplied or
not.

Or is the correct solution to also add a bolean type OPTION_BOOLEAN for
-o?
--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com

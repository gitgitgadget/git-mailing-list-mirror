From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: device files should be handled by git
Date: Thu, 27 Jun 2013 15:08:42 +0200
Message-ID: <20130627130842.GB27497@paksenarrion.iveqy.com>
References: <21095513-708E-4F82-88D0-A312B74BA7F4@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Perry Wagle <wagle@mac.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 15:09:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsBwi-0005BB-RN
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 15:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880Ab3F0NJG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jun 2013 09:09:06 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:48172 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab3F0NJD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 09:09:03 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so393805lbh.7
        for <git@vger.kernel.org>; Thu, 27 Jun 2013 06:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hOc8k2AkKG6l7/F8MwfFyNVXQKPScJgt0sGh7JaPWMM=;
        b=tsDboJrYipT3IE709Ssa336W1eZ0bxM1i4ZvKrZBfJ5cSXDAGFTWGc4MIJJtyCe2bl
         kz/s4yhtvcK7kOGTF6YItp0Udy6kcIiUmZM3HZDqjHSoURfLpFIaSJKTggrCSCSHtsRE
         3j32AroarWSYbMd4kDooNCSxdcpEQbuksbBDFqFSzsMmU3w+vuzrkPs02C4+oRynjb8l
         ZiB1rTpkdRmP7zwDUIyd3XfjFla6dqT8+pHTJj9ejTKbCec5zFLmpgFhumsy5seohIo+
         2kVJaE7QtbB06CamtinWvXEwF42bmkEuyp9ROE1hUmjVEP7xbJ42t6zqjTw6TfbJQz8X
         SlTQ==
X-Received: by 10.152.8.72 with SMTP id p8mr4255763laa.70.1372338540849;
        Thu, 27 Jun 2013 06:09:00 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id m14sm1155840lbl.1.2013.06.27.06.08.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 27 Jun 2013 06:09:00 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UsBwI-0001TP-Qe; Thu, 27 Jun 2013 15:08:42 +0200
Content-Disposition: inline
In-Reply-To: <21095513-708E-4F82-88D0-A312B74BA7F4@mac.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229099>

On Wed, Jun 26, 2013 at 08:27:56PM -0700, Perry Wagle wrote:
> Hi --
>=20
> I have a disk image of a small embedded device whose root file system=
 I'd like to check-in to git as a means of distributing its GPL'd softw=
are.  In that disk image are device files, which GIT studiously ignores=
=2E  If symlinks are handled (contents being the path that the symlink =
points at), I don't see why device files can't be handled (contents bei=
ng the type (char or block) and the major and minor device number).  TA=
R, for example, handles this fine, except that using tar in git sort-of=
 goes against the granularity of the objects being modified (like addin=
g a bunch of extra "sd??" devices), such that you are modifying a whole=
 tar ball instead of the individual (device) files.
>=20
> Is there a reason not to handle device files other than "its not trad=
itional"?  That's the only reason given in google or the IRC channel.
>=20
> Thanks!

In linux you can't create device files if your not root. On windows
those files won't even exists (afaik).

Wouldn't this be very unportable and hard to use (meaning that you need
to handle your git repo as root or give git setuid root)?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com

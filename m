From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [BUG] git config: cygwin git version 1.6.1.2 does not deletes 
 empty sections
Date: Wed, 6 May 2009 22:43:27 +0200
Message-ID: <20090506224327.23c69a06@gmail.com>
References: <85647ef50905060850t2e6c2051jfa6d3596b680cc74@mail.gmail.com>
	<85647ef50905060904w49879c57r4a5773a487f09c85@mail.gmail.com>
	<40aa078e0905061108o21830f07xfb9d5c185c93fda6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Wed May 06 22:46:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1o0t-0001Cw-QC
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 22:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761643AbZEFUnh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2009 16:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761617AbZEFUng
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 16:43:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:45864 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761635AbZEFUne convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2009 16:43:34 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1144787fga.17
        for <git@vger.kernel.org>; Wed, 06 May 2009 13:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=cakc0dIfwlWRR76sK2g9FuVd8cjNzBxMPsPjbeaMRzc=;
        b=d8HxN5UR04PXK1abRFdnshQDy38EvGMHRSaCgUsVafIpcOcFQavBVYvk2aqNz3OH9J
         KgTBdXIWGFuOcUmZU+KJxL/boO0nKOKpuTIJlQRg+FRwhyBPXe2b6/Omtr0gdciBe51Z
         iColUV6aLcLm/QL2e5yGpVgxlmcFbAcSOQjzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=jczWglpkyF+0Ryd55yz0Tftb820GgVw6yORHZXU7GvReBp1BKIBS/IsdEr7SfXduJ4
         ktF1ikvDfh+2y0cKTuXm3xh4GelhC8E6JRpCquA9TSQoWbFeuI5LLuRPtF2GJj7k1UTe
         3i9RhkFqATsZZJeUDO8NZKhBDz0jqVJQLBPJs=
Received: by 10.86.90.2 with SMTP id n2mr1716852fgb.61.1241642613182;
        Wed, 06 May 2009 13:43:33 -0700 (PDT)
Received: from localhost (77-254-88-19.adsl.inetia.pl [77.254.88.19])
        by mx.google.com with ESMTPS id d4sm15894524fga.9.2009.05.06.13.43.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 May 2009 13:43:33 -0700 (PDT)
In-Reply-To: <40aa078e0905061108o21830f07xfb9d5c185c93fda6@mail.gmail.com>
X-Mailer: Claws Mail 3.7.1 (GTK+ 2.14.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118386>

Erik Faye-Lund <kusmabite@googlemail.com> wrote:

> On Wed, May 6, 2009 at 6:04 PM, Constantine Plotnikov
> <constantine.plotnikov@gmail.com> wrote:
> > The bug is also confirmed on MSYS git version 1.6.2.2.1669.g7eaf8.
>=20
> The same issue is present in git 1.6.2.1 on Linux. Not that I'm too
> sure it's really a bug, though ;)
>=20

Happens also in master (v1.6.3-rc4-29-g8146f19). IMO this is because
git_parse_file() reports only *variables*, not *sections* and
store_aux() doesn't find empty section.

--
Micha=C5=82 Kiedrowicz

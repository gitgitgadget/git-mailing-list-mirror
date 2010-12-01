From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCHv3 2/3] cvsimport: fix the parsing of uppercase config options
Date: Wed, 1 Dec 2010 09:59:42 -0500
Message-ID: <AANLkTi=cb0i28oGi9vrYfEyU_fPHhQGhNNtramtCpCHy@mail.gmail.com>
References: <cover.1291207768.git.git@drmicha.warpmail.net>
 <7vd3pmw9n5.fsf@alter.siamese.dyndns.org> <b61288036e756c78709438491416d573459a732e.1291207768.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 01 16:00:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNoAL-0005WF-KR
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 16:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770Ab0LAPAG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 10:00:06 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56631 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669Ab0LAPAF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 10:00:05 -0500
Received: by iwn35 with SMTP id 35so26984iwn.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 07:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=mtLbIIotKZFlzmCMcEaeD0XsbX2dd7ICeDCPIE8Mb10=;
        b=CE1uy0Z0g3b6K1B5EYoGRUHO/A7I0hnHTNt4TAhfM3IpMVy1s7oMZoyzZLgWXIo0sX
         tOIgmv5Z3g/Pdo2C8QO5GzIn1FoOBvKBs5rlnZsSzJUBGNRifanj9GXNSTKa3eHLx94K
         xJD5zI3IMk+PdNVSkJK6laEdVlpKM8cVtf3X8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CqmDh2pW1x+Ce1c9YS3bTvzG6YQophoXihu42X7dpatORb0T1K+E6IhW3/ZyacckdZ
         V97YBkkZNm/ZZdV4TX/kw+2/os6JNkPjv0zqQyteNMGhVTKAsyTq2SHKNs3NOHcqNuEh
         8jFHUU/+6AIqBygX+yfZNuWibnlDA6nBZDfvk=
Received: by 10.231.31.136 with SMTP id y8mr8945727ibc.145.1291215603509; Wed,
 01 Dec 2010 07:00:03 -0800 (PST)
Received: by 10.231.33.1 with HTTP; Wed, 1 Dec 2010 06:59:42 -0800 (PST)
In-Reply-To: <b61288036e756c78709438491416d573459a732e.1291207768.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162526>

On Wed, Dec 1, 2010 at 7:53 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Fix this by making cvsimport expect the config item "cvsimport.capita=
l-r"
> for the command line option "-R" etc.

Good point to fix this, thanks. But 'capital-r' will muddy the waters
further. When accepting configuration from git-config, make all these
values the full expanded name.

So cvsimport.remote (for -r) and cvsimport.revisions (or
trackrevisions perhaps) seem more appropriate.

cheers,


m
--=20
=A0martin.langhoff@gmail.com
=A0martin@laptop.org -- School Server Architect
=A0- ask interesting questions
=A0- don't get distracted with shiny stuff=A0 - working code first
=A0- http://wiki.laptop.org/go/User:Martinlanghoff

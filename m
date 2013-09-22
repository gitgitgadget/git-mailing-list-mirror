From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 07/17] fixup! index-pack,
 pack-objects: allow creating .idx v2 with .pack v4
Date: Sat, 21 Sep 2013 21:39:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309212137090.312@syhkavp.arg>
References: <1379771883-10278-1-git-send-email-pclouds@gmail.com>
 <1379771883-10278-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_uenCwaz8UQTRA8dqrXnkTQ)"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 22 03:39:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNYeN-0008FJ-PU
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 03:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596Ab3IVBjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 21:39:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:45939 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752505Ab3IVBjr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 21:39:47 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MTI00JMT7AATU80@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 21 Sep 2013 21:39:46 -0400 (EDT)
In-reply-to: <1379771883-10278-8-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235152>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_uenCwaz8UQTRA8dqrXnkTQ)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Sat, 21 Sep 2013, Nguyễn Thái Ngọc Duy wrote:

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  sha1_file.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index e98eb8b..ef6ecc8 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -605,7 +605,9 @@ static int check_packed_git_idx(const char *path,  struct packed_git *p)
>  		}
>  		p->sha1_table = pack_map;
>  		p->sha1_table += 12;
> -	} else
> +	} else if (version == 2)
> +		p->sha1_table = idx_map + 8 + 4 * 256;
> +	else
>  		p->sha1_table = NULL;

I folded it into "pack v4: initial pack index v3 support on the read 
side" rather than "index-pack, pack-objects: allow creating .idx v2 with 
.pack v4".


Nicolas

--Boundary_(ID_uenCwaz8UQTRA8dqrXnkTQ)--

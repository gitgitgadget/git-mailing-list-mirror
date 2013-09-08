From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 05/12] index-pack: parse v4 header and dictionaries
Date: Sat, 07 Sep 2013 22:14:29 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309072211050.20709@syhkavp.arg>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378550599-25365-1-git-send-email-pclouds@gmail.com>
 <1378550599-25365-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_BZL9anx73rKNB3NbGCWebw)"
Cc: git@vger.kernel.org
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 04:14:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIUWY-0000QO-En
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 04:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310Ab3IHCOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 22:14:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11832 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab3IHCOg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 22:14:36 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSS00GAPBK6I350@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 07 Sep 2013 22:14:30 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 7B54F2DA0547; Sat, 07 Sep 2013 22:14:30 -0400 (EDT)
In-reply-to: <1378550599-25365-6-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234161>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_BZL9anx73rKNB3NbGCWebw)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Sat, 7 Sep 2013, Nguyễn Thái Ngọc Duy wrote:

> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---

[...]

> @@ -1677,6 +1727,15 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
>  	free(objects);
>  	free(index_name_buf);
>  	free(keep_name_buf);
> +	free(sha1_table);
> +	if (name_dict) {
> +		free((void*)name_dict->data);
> +		free(name_dict);
> +	}
> +	if (path_dict) {
> +		free((void*)path_dict->data);
> +		free(path_dict);
> +	}

The freeing of dictionary tables should probably have its own function 
in packv4-parse.c.  and a call to it added in free_pack_by_name() as 
well.


Nicolas

--Boundary_(ID_BZL9anx73rKNB3NbGCWebw)--

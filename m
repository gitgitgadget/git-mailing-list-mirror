From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 2/6] connect: uniformize and group CONNECT_DIAG_URL
 handling code
Date: Mon, 2 May 2016 06:56:54 +0200
Message-ID: <5726DE16.3030402@web.de>
References: <1462082573-17992-1-git-send-email-mh@glandium.org>
 <1462082573-17992-3-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, tboegi@web.de
To: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 02 06:58:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ax5vq-0000WO-Mx
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 06:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbcEBE5c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 00:57:32 -0400
Received: from mout.web.de ([212.227.17.11]:56151 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724AbcEBE5b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 00:57:31 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MKrU4-1ax5uo1Uy8-00017Y; Mon, 02 May 2016 06:57:02
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <1462082573-17992-3-git-send-email-mh@glandium.org>
X-Provags-ID: V03:K0:olXWhJtF2YV335RENEVSk9zLjbtEcOrIhAz8LLrHIkwRqOjPQJ2
 na12iPwT4ImgpgMTEmO4QkkgnLyqVaNJvG1gapRRsUkEjr/XYc7zF/qR6yfHve3v+qnKnAQ
 Z7xnMYWMReJ2Xcp7hQjaCeeQjuf5+Xi+0FwCTrBPArNiWh02alBOwtK/FrY/SiCWJ2t1qVX
 RSxckn3+NY5KrpycItElQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jI4Gzu/H0u4=:yw4GW+ptnAm6XkBsYxHBmA
 4bE+5rpjyFXqydnJTBZg73Wb8++8RWXy7W1oUQ13hCb5xOUJwGm+q+VJHFsUd6M8A2QGmixj1
 n8TXR3Lf/E5WJJ0x0uO5cIR5qmZ74nR07SjUwikelwKg0AyKaYbWw6tDZNYVrQL5yKqHpRewH
 +EiLBS6zsJ0ug45Cay6wFgkbfn7Ivb9KPVQOYzVIopFlAx9WqVSsJIz9bdXs6083ZTeM3AuUQ
 ZDbzoB+scekQQw8qKW7RBjFxVsBIEtBOvfthGb5x1ledEkx2bNujJDryEjZzdQK491ok2Lka5
 sPuRj5F9PrK9oo75OXt6fg3/+sVMH2zt5IWijHI8AegU24vUHWAgx523gqLP92JcKXoFzc/Wn
 J8MOt+A5wXM6KinI5Z0ZQTlTZwDyxy4ub47r6a29n4hdREqFldG2RBXWuo5lpKVs+8a+f6cT6
 uUYV6G63s0teLxiL3FO5ItXmkarQxhqokfmkJeJtaeO0483FW9LLDu/8VzHA4wkUwNEuT6i/W
 nYN6Zkk/5hziDTR8p13a+hYVpbz/hYKgaByiyS7FEzG5Ip/SMCWFBbhvJcNrkAdwl1G1QO4TX
 MWIjnMBdxGTaFsIIy5rWoDR9Tzs52/FqHWIoHoKc3T/hbGPVwzVvDQpCv7XZsGX1Y4w7S0YbQ
 1UVnge4HUVpC7rXU53K2Efldpx5NP+UYqiL4MIELgMhQ5SnFCaAGnM6Q7zYLFVzH33DZRnbZs
 YXGUuqCoyHttH+eP2aQsDgNZjjpHVKE81IhwE5MJbeglfet6uANElaI/BR6MB6q8thWWSzk1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293218>

On 05/01/2016 08:02 AM, Mike Hommey wrote:
> +	if (flags & CONNECT_DIAG_URL) {
>   		printf("Diag: url=%s\n", url ? url : "NULL");
>   		printf("Diag: protocol=%s\n", prot_name(protocol));
>   		printf("Diag: hostandport=%s\n", hostandport ? hostandport : "NULL");
> +		printf("Diag: userandhost=%s\n", host ? host : "NULL");
> +		printf("Diag: port=%s\n", port ? port : "NONE");
>   		printf("Diag: path=%s\n", path ? path : "NULL");
>   		conn = NULL;
Does it make sense  to write the host twice?
If things are cleaned up, would something like this make sense ?

		printf("Diag: url=%s\n", url ? url : "NULL");
  		printf("Diag: protocol=%s\n", prot_name(protocol));
		printf("Diag: user=%s\n", user ? user : "NULL");
  		printf("Diag: host=%s\n", host ? host : "NULL");
		printf("Diag: port=%s\n", port ? port : "NONE");
  		printf("Diag: path=%s\n", path ? path : "NULL");
  		
or
		printf("Diag: url=%s\n", url ? url : "NULL");
  		printf("Diag: protocol=%s\n", prot_name(protocol));
                 if (user)
			printf("Diag: user=%s\n", user);
  		printf("Diag: host=%s\n", host ? host : "NULL");
		printf("Diag: port=%s\n", port ? port : "NONE");
  		printf("Diag: path=%s\n", path ? path : "NULL");

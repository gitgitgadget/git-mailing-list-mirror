From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v7 1/9] connect: document why we sometimes call get_port
 after get_host_and_port
Date: Sun, 22 May 2016 08:07:05 +0200
Message-ID: <399331a6-dadb-c318-b0e0-c83e0f81ecb0@web.de>
References: <20160521231732.4888-1-mh@glandium.org>
 <20160521231732.4888-2-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, tboegi@web.de
To: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 08:07:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4MY8-0004u8-TJ
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 08:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbcEVGHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2016 02:07:36 -0400
Received: from mout.web.de ([212.227.17.12]:61683 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108AbcEVGHf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 02:07:35 -0400
Received: from birne9.local ([195.252.60.88]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0LaTid-1bq61z0o7r-00mM0S; Sun, 22 May 2016 08:07:08
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.0
In-Reply-To: <20160521231732.4888-2-mh@glandium.org>
X-Provags-ID: V03:K0:Hbjnyhzp91Bq5DUapSvwIKslm0us4sSQ6GjG7Ra0hGgFwLzRnas
 n1JiN+kvClOush6qKBLWPiRcIn8ckEwIFxTpPIXDZsJrbHL8sEm/hVVEA+G1PRa1AmiFB3M
 p6UNED+G/nZaqvnz0sim+1MR49YzpW40gMze6YiYLZB2bR1DLdUryemD8ijROt3dvhLEv8d
 rMG8IsTRwoPPspeP3B2aQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e9zr70RQ+Xo=:7vk58UenoK4qH58VE390Db
 4UePPzLqKmJt59uRvnii04HMuUu3txpaks+BCN5Vp6JpklPINpliRO/Qu/9PowNr0sJ2pjDoQ
 jjZTGAR5uRilqzn2lDRYxqPPm9fV2EO5odHkkLVlK3LLc6wRuiOqzFef9cE2X62nmzPIc45iX
 sFJ3Y3yGutFsP7lF3ADDYTWSaZuwyBPIDr4wsUkwM7bjvjy0abGUvFrck5h+84Bp1U7MaMDGs
 0rf84P/qWhyuPGgDFnRrxQQdza8Wrs5K+jTIhfrPn1iiBNB8YKhF7VCHcu+irxxjrQxXavDoT
 h94s7Z0BqZhsFZMmPmfxtBHd43EMV23yJQhlXMLkI7rcGFx1onqcnkwr8Kzjrz/wW6w1Y+c/d
 nFcHQd+GDjxoZobRu+pny9Cl69jPAyEuwhyTegSVZSlm5mJ2kQTaIIpBIBivVk9wM7ArQVRr8
 3rjqkCeuTzf7GCNHjIqFueKap1QCawFiUPV+ndaKQXGATwuW0m64N4QyxULERE32TpJv/WsLm
 w7vL2SsUVazt3jU0ng7JgnK3ZJRrPTUT7Af7BWWQ+KFUh0fJYFiUnWif9qttIfy4JItValx0s
 bTKYiXVFwU/9SiV6xPu9uWptYBF+5jTVzYImgC6Oc8AxrvZfK0WzW0gdAVXK/A6/6i+Fk/OV+
 Xutc2PcpcDJBOP9vYuqp7q9oh7f0qx4H0eMZRBZwt6Svvxw2CBGTHzOpjVEEVh10HGT362pFT
 PZMVeBvvbZE+IpDyj9ak8j6YfXudkfQnrLtmk7+I14w4rVmmHJYsTFOXLSdAI8sL2Zv+429/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295257>

On 22.05.16 01:17, Mike Hommey wrote:
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  connect.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/connect.c b/connect.c
> index c53f3f1..caa2a3c 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -742,6 +742,12 @@ struct child_process *git_connect(int fd[2], const char *url,
>  			transport_check_allowed("ssh");
>  			get_host_and_port(&ssh_host, &port);
>  
> +			/* get_host_and_port may not return a port even when
> +			 * there is one: In the [host:port]:path case,
> +			 * get_host_and_port is called with "[host:port]" and
> +			 * returns "host:port" and NULL.
> +			 * In that specific case, we still need to split the
> +			 * port. */
Is it worth to mention that this case is "still supported legacy" ?

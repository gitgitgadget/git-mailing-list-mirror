Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 662D51FC19
	for <e@80x24.org>; Sat, 25 Mar 2017 05:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967205AbdCYFrS (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 01:47:18 -0400
Received: from mout.web.de ([212.227.15.3]:51271 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967120AbdCYFrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 01:47:16 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Le8Ca-1cO9HV3g0i-00ptIX; Sat, 25
 Mar 2017 06:47:09 +0100
Subject: Re: [PATCH v2 1/2] pkt-line: add packet_writel() and
 packet_read_line_gently()
To:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org
References: <20170324152726.14632-1-benpeart@microsoft.com>
 <20170324152726.14632-2-benpeart@microsoft.com>
Cc:     benpeart@microsoft.com, christian.couder@gmail.com,
        larsxschneider@gmail.com
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <7a2c73c8-bb09-12ec-dd8d-99c5363f9bb4@web.de>
Date:   Sat, 25 Mar 2017 06:47:09 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170324152726.14632-2-benpeart@microsoft.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:xTpLutqRKXN2l1xFhFEgtTc/uDSpOKknM4ex7UbMbq4PJGa4cqc
 A7UMtOxZ0ZoGKOOOD8qbeQbFHdn8b4ehlSIEOZYCL3nWIQEZBcoTLHkNa7zosTpMq0x27Ns
 Hx3rQuAdr800xVMj2+YjcPZ3XBzMixdNu/o5GmTaYgupNveDXBmc2soIooe/P7Bc6mTQC2L
 KAvZKvFtckj1QIGJe7Idw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XZPMse5kn5Q=:WmWtW2sLqIZJ5Jdrq1h4Nl
 AtD80xJXUQWt5X4aUBYGSs9thAkUgJvnv4AJgsXL6w9MeHtqM/Y9XksfzUpCyuwk3ml+lKUWg
 8htvOirgt9SZYNS+biNLdP/vmiou7TPCkWHNI+tu8qRknzYAH8pI6PG6M6TdM6+AVprt28OV0
 ij/IEKErHrQV8CiSoTTH9nmO87bXJl8zauqKCFm1c9jdaCfS/yOsJX6HumkKtE0c3kby52GoS
 CFquyijMDwAHcsixvUTH9CsGyI4NKu01t/AeKt9UzUFA0gGuoJzpTTUj0lmxyn76CU7v+yO2f
 GrwcOEayt1BbDo9ls+B9C4S9HoIgg9RLPH0S0sv7QTLeNiIgWqZuUf48bRL38d7M8Q4CcdNSh
 roq7QjBAw+KEtyx5SSdSURo7APFZNpUvLpRi+cxH3aNWiHpBAZFC5GJL/zzIrMhj9PpeBLc2g
 VE/TqjL3uUn3pKpNN4Un/Ku/1w5WNXs08mjRbZXkp9X9Ipg6gjucSXq1W0r5HkhVdkuZgJom6
 pIDF/xZlvp3ja6fqIFtfKxz62z/5uwgrH6DPJn7+fRThKMiHMOBT/Vn4uHkfu4T9N/2EMh8JX
 V8PcPSatdmloSiXR5Zb5f7WKAI38opH+1pC5GpAzJQzMF/dgkrc+gZPMimqBjur7OjFDIIru0
 7sA75PpEQDwI3U6qnOd+JYVJvkoqcvYE1Ffv6RatB97vDrzwA1vTpxjucONMd3RyR0ESBbE1A
 oy22Zd/o4HgNplacL5Rs74P0kFTO7LTA1VvbgTzMwBnxl5wOWtOm9VrWWEcJJXnoEU8WaGVQL
 wNFGN/z
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-03-24 16:27, Ben Peart wrote:
> Add packet_writel() which writes multiple lines in a single call and
> then calls packet_flush_gently(). Add packet_read_line_gently() to
> enable reading a line without dying on EOF.
> 
> Signed-off-by: Ben Peart <benpeart@microsoft.com>
> ---
>  pkt-line.c | 31 +++++++++++++++++++++++++++++++
>  pkt-line.h | 11 +++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/pkt-line.c b/pkt-line.c
> index d4b6bfe076..2788aa1af6 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -171,6 +171,25 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
>  	return status;
>  }
>  
> +int packet_writel(int fd, const char *line, ...)
The name packet_writel is hard to distinguish from packet_write.
Would packet_write_lines make more sense ?

> +{
> +	va_list args;
> +	int err;
> +	va_start(args, line);
> +	for (;;) {
> +		if (!line)
> +			break;
> +		if (strlen(line) > LARGE_PACKET_DATA_MAX)
> +			return -1;
> +		err = packet_write_fmt_gently(fd, "%s\n", line);
> +		if (err)
> +			return err;
> +		line = va_arg(args, const char*);
> +	}
> +	va_end(args);
> +	return packet_flush_gently(fd);
> +}
> +
I don't think that this va_start() is needed, even if it works.

int packet_write_line(int fd, const char *lines[])
|
	const char *line = *lines;
	int err;
	while (line) {
		if (strlen(line) > LARGE_PACKET_DATA_MAX)
			return -1;
		err = packet_write_fmt_gently(fd, "%s\n", line);
		if (err)
			return err;
		lines++;
		line = *lines;
	}
	return packet_flush_gently(fd);
]



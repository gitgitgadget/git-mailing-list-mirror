From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Include log_config module in apache.conf
Date: Wed, 11 Mar 2009 15:33:27 -0400
Message-ID: <E7E9DDFD-F8F6-4B39-A3E3-48CC1C8F5BBC@silverinsanity.com>
References: <alpine.LNX.1.00.0903102320170.19665@iabervon.org> <alpine.DEB.1.00.0903111240150.10279@pacific.mpi-cbg.de> <7vab7r6g59.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 20:35:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhUCl-00036A-Lu
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 20:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532AbZCKTdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 15:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752471AbZCKTde
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 15:33:34 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:53264 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503AbZCKTdd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 15:33:33 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id C06D51FFC3FC; Wed, 11 Mar 2009 19:33:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.1.115] (cpe-74-74-137-205.rochester.res.rr.com [74.74.137.205])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 7560A1FFC043;
	Wed, 11 Mar 2009 19:33:22 +0000 (UTC)
In-Reply-To: <7vab7r6g59.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112966>


On Mar 11, 2009, at 2:58 PM, Junio C Hamano wrote:

> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index a0d4077..f460e40 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -4,7 +4,9 @@ DocumentRoot www
> LogFormat "%h %l %u %t \"%r\" %>s %b" common
> CustomLog access.log common
> ErrorLog error.log
> -LoadModule log_config_module modules/mod_log_config.so
> +<IfModule !mod_log_config.c>
> +	LoadModule log_config_module modules/mod_log_config.so
> +</IfModule>
>
> <IfDefine Darwin>
> 	LoadModule log_config_module modules/mod_log_config.so

Isn't this last line redundant now?

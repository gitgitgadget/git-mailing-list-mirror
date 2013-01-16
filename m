From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 07/14] imap-send.c: inline imap_parse_list() in imap_list()
Date: Wed, 16 Jan 2013 09:26:10 +0100
Message-ID: <50F66422.3010502@alum.mit.edu>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu> <1358237193-8887-8-git-send-email-mhagger@alum.mit.edu> <20130115185147.GB14552@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 09:26:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvOKR-00078i-NN
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 09:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758687Ab3API0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 03:26:14 -0500
Received: from ALUM-MAILSEC-SCANNER-5.MIT.EDU ([18.7.68.17]:52476 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758653Ab3API0M (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2013 03:26:12 -0500
X-AuditID: 12074411-b7fa36d0000008cc-d8-50f66424ce7e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 09.E8.02252.42466F05; Wed, 16 Jan 2013 03:26:12 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0G8QAhX029985
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 16 Jan 2013 03:26:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <20130115185147.GB14552@ftbfs.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqKuS8i3A4Ow5HouuK91MFg29V5gt
	WmefYXFg9nj1pJ/N4+IlZY/Pm+QCmKO4bZISS8qCM9Pz9O0SuDOu/GlhK3jLXHFwqXAD4wzm
	LkZODgkBE4mjbxdD2WISF+6tZ+ti5OIQErjMKDHvbRMzhHOcSWJ1zxMmkCpeAW2JjU/fMYLY
	LAKqEm83/2IBsdkEdCUW9TSD1YgKhEn0vj7HCFEvKHFy5hOwGhEBBYnpf0E2cHIwC1hLrHh9
	GKxeWCBIYk1HFzvEsnmMEpOudYI1cwroS/zs+8AI0aAj8a7vATOELS+x/e0c5gmMArOQ7JiF
	pGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3RN9XIzS/RSU0o3MUKCV3AH44yTcocY
	BTgYlXh4v+R9DRBiTSwrrsw9xCjJwaQkymsU9y1AiC8pP6UyI7E4I76oNCe1+BCjBAezkgjv
	MnugHG9KYmVValE+TEqag0VJnJdvibqfkEB6YklqdmpqQWoRTFaGg0NJgvdtElCjYFFqempF
	WmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPChW44uB0QqS4gHa+ysRZG9xQWIuUBSi9RSjLsf2
	3+3PGYVY8vLzUqXEeZWTgYoEQIoySvPgVsBS1StGcaCPhXlNQKp4gGkObtIroCVMQEs27f0M
	sqQkESEl1cBYcfH7ru/XungSryw8Zdq3/RI7W0a3NCtf+LdIzdj8gAsyqtzFHy5sM2msu3bw
	pIHGgrQ475lmUj3/G/j3M1pWNdUvXrDHjIkjqO9CGnPuXp79OQUhPKqvUpgPz345 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213739>

On 01/15/2013 07:51 PM, Matt Kraai wrote:
> On Tue, Jan 15, 2013 at 09:06:25AM +0100, Michael Haggerty wrote:
>> -static struct imap_list *parse_imap_list(struct imap *imap, char **sp)
>> +static struct imap_list *parse_list(char **sp)
> 
> The commit subject refers to imap_parse_list and imap_list whereas the
> code refers to parse_imap_list and parse_list.

Yes, you're right.  Thanks.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

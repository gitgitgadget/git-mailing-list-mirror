From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] fast-import: Remove redundant assignment of 'oe' to itself.
Date: Sun, 26 May 2013 22:08:23 +0200
Message-ID: <51A26BB7.3060702@gmail.com>
References: <1369598719-10798-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: David Barr <david.barr@cordelta.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Sun May 26 22:08:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UghF2-0001Wz-1u
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 22:08:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037Ab3EZUI2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 16:08:28 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:51314 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008Ab3EZUI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 16:08:27 -0400
Received: by mail-ee0-f43.google.com with SMTP id d41so3588231eek.2
        for <git@vger.kernel.org>; Sun, 26 May 2013 13:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=OKaTsLQ2XkAL4EJmrTfB33doosPL5w/iQeQgL+OW83E=;
        b=mTQOieLUrjlhAttqcjpVH+pXUMct7WZ4NMCKuxHA2QBCdP7tXENtUjL2Op2z3A3dGN
         kqwkxJQbFRvF94jWKCrWVY+TDoh4qqjQIyskIHpllh+vxj6FbX4J+B3HimMEjwEMXUbH
         bOf+FiLQx1776w7wAGaoBAZgZL6gj3GdnXlnbeTBWr3hqE2Sw8xlBoGCn6m7uMpU7Rgv
         /SkZW8yAv/E5d4fHNr9urUGWesFYVkNNFDGc8neRHBpQlImQfV7UTWkWRDqsEcoAcvJd
         8mTty5t+e68y9h6wF1LK1vU1Zyg4PPxxTTrKa4tRAIR65bRaHQKZiUIqMJIhsAYRpMBp
         Bc9A==
X-Received: by 10.15.108.6 with SMTP id cc6mr51216744eeb.28.1369598906383;
        Sun, 26 May 2013 13:08:26 -0700 (PDT)
Received: from [192.168.178.20] (host93-95-dynamic.6-79-r.retail.telecomitalia.it. [79.6.95.93])
        by mx.google.com with ESMTPSA id y10sm37309675eev.3.2013.05.26.13.08.24
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 26 May 2013 13:08:25 -0700 (PDT)
In-Reply-To: <1369598719-10798-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225567>

On 05/26/2013 10:05 PM, Stefan Beller wrote:
> Reported by cppcheck.
> 
> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
> ---
>  fast-import.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fast-import.c b/fast-import.c
> index 5f539d7..0142e3a 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2914,7 +2914,7 @@ static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
>  static void parse_cat_blob(void)
>  {
>  	const char *p;
> -	struct object_entry *oe = oe;
>
This was done on purpose, to avoid spurious warnings with (at least)
some versions of GCC.

> +	struct object_entry *oe;
>  	unsigned char sha1[20];
>  
>  	/* cat-blob SP <object> LF */

Regards,
  Stefano

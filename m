From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 01/11] refs.c: constify the sha arguments for ref_transaction_create|delete|update
Date: Sat, 19 Apr 2014 20:56:10 +0200
Message-ID: <5352C6CA.7080803@alum.mit.edu>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com> <1397763987-4453-2-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 20:56:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbaR1-0006Na-4Y
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 20:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755177AbaDSS4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2014 14:56:15 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:46610 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754851AbaDSS4N (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Apr 2014 14:56:13 -0400
X-AuditID: 12074411-f79ab6d000002f0e-7a-5352c6cc1b8b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 72.3A.12046.CC6C2535; Sat, 19 Apr 2014 14:56:12 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2858.dip0.t-ipconnect.de [93.219.40.88])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3JIuAqn018095
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sat, 19 Apr 2014 14:56:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1397763987-4453-2-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1D1zLCjYYP4xeYuuK91MFv8m1Dgw
	eSzYVOrxeZNcAFMUt01SYklZcGZ6nr5dAnfGy/uHmQvmsFTcWdDK1sC4m7mLkZNDQsBEonv2
	SiYIW0ziwr31bF2MXBxCApcZJQ5+vcYIkhASOMckcWdlPYjNK6AtcXhfKzuIzSKgKjFr4xWw
	QWwCuhKLepqBBnFwiAoESfw5qwhRLihxcuYTFhBbRMBOYv2thWDlwgJpEnc3/WeCGF8psf/2
	FmaQVk4BZ4kLhwtATAkBcYmexiCQCmYBHYl3fQ+YIWx5ie1v5zBPYBSYhWTBLCRls5CULWBk
	XsUol5hTmqubm5iZU5yarFucnJiXl1qka6qXm1mil5pSuokREp6COxhnnJQ7xCjAwajEw6v4
	LzBYiDWxrLgy9xCjJAeTkijv3/VBwUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeGfsAcrxpiRW
	VqUW5cOkpDlYlMR5+Zao+wkJpCeWpGanphakFsFkZTg4lCR4Xx0FahQsSk1PrUjLzClBSDNx
	cIIM55ISKU7NS0ktSiwtyYgHxWh8MTBKQVI8QHt7QNp5iwsSc4GiEK2nGHU5LjSsaGESYsnL
	z0uVEuedAVIkAFKUUZoHtwKWjF4xigN9LMx7HKSKB5jI4Ca9AlrCBLTk75kAkCUliQgpqQZG
	7TAnVtaSNwdv+Pc9v1Qb/efP5Zqqcm6bZCPVyn8Ced8k1k7pnqm8it1DjoFZ4WWTl+RR1jiG
	p3u+tQhWdy//tfWEmMTskoUtuscXSxxb7WW54W6MdhHnp+T8BJ9G9aluO6wOCl9g 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246525>

On 04/17/2014 09:46 PM, Ronnie Sahlberg wrote:
> ref_transaction_create|delete|update has no need to modify the sha1
> arguments passed to it so it should use const unsigned char* instead
> of unsigned char*.
> 
> Some functions, such as fast_forward_to(), already have its old/new
> sha1 arguments as consts. This function will at some point need to
> use ref_transaction_update() in which case this change is required.

Good, thanks.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

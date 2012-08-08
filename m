From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC v3 06/13] Read index-v5
Date: Wed, 08 Aug 2012 14:18:09 +0200
Message-ID: <50225901.5040405@viscovery.net>
References: <1344424681-31469-1-git-send-email-t.gummerer@gmail.com> <1344424681-31469-7-git-send-email-t.gummerer@gmail.com> <CACsJy8DZ-+0XD2HxkTFuXKXJFH66MCLLrfHtcMF-1GqBb2AmVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	robin.rosenberg@dewire.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 14:18:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz5DS-00074E-Tt
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 14:18:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758020Ab2HHMSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 08:18:18 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:15365 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758006Ab2HHMSR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 08:18:17 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Sz5DF-0002VX-Jk; Wed, 08 Aug 2012 14:18:09 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4E83D1660F;
	Wed,  8 Aug 2012 14:18:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <CACsJy8DZ-+0XD2HxkTFuXKXJFH66MCLLrfHtcMF-1GqBb2AmVg@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203088>

Am 8/8/2012 14:05, schrieb Nguyen Thai Ngoc Duy:
> uOn Wed, Aug 8, 2012 at 6:17 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
>> +static struct cache_entry *read_entry(struct directory_entry *de,
>> +                       unsigned long *entry_offset,
>> +                       void **mmap,
>> +                       unsigned long mmap_size,
>> +                       unsigned int *foffsetblock,
>> +                       int fd)
>> +{
>> ....
>> +               if (crc_wrong) {
>> +                       /* wait for 10 milliseconds */
>> +                       usleep(10*1000);
>> +                       munmap(*mmap, mmap_size);
>> +                       *mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
>> +               }
> 
> Do we really need to munmap and mmap again?

Yes. mmap may be the pread()-based implementation from compat/mmap.c.

-- Hannes

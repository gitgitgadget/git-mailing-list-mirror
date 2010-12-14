From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 09/19] tree-diff.c: reserve space in "base" for pathname concatenation
Date: Tue, 14 Dec 2010 14:43:48 +0700
Message-ID: <AANLkTimzmq8gUpXUZ801Q+pua_mZMHTJ6wYt_CwcTr3v@mail.gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
 <1292233616-27692-10-git-send-email-pclouds@gmail.com> <7vlj3t35ol.fsf@alter.siamese.dyndns.org>
 <AANLkTi=5QgkBd434=Z7MCA_ZNZCXVyXJYh_fd1A+B2ue@mail.gmail.com>
 <7vvd2wvs0m.fsf@alter.siamese.dyndns.org> <4D071DAA.3070400@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 14 08:45:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSPZf-0001nN-SI
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 08:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418Ab0LNHoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 02:44:21 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39813 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842Ab0LNHoU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 02:44:20 -0500
Received: by wwa36 with SMTP id 36so270232wwa.1
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 23:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=86jNcUm6WWQ07rCe02nx3C5k8FeJkwDsX4tdbAEuJaE=;
        b=W25P9lsruno6xAvc4PaBVEmLV/U43CDBCeEOsbgQJ1Tqxzd6lJD+5GzIPhYvcqyJqO
         0a8Z+ZeJvkuuQTnphWZuAK1SpG6Xg8FHwzhcnZkOyEPdZhVk+GgLmV4YrFwujFUF4oXo
         2F2BjjgN/MzFfr0/+e/Za7YS++gr89aPanIp8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=h2VD2Bs8WxGWWkp31/kqxY83Zi0Mhsdszd6lGB0cC+k3PeIYqwtd7Wvuol/DO47Vet
         LnFf6gdSHo/s3HG5mAS/nDTflgHUcuQmLCgB4gjBMsFEnoS5+yjSsGtKnZ+730wDMs9i
         TQxBRQaHcCs4wuV+l9C7Cyp+p2LIz33JYqZeA=
Received: by 10.216.52.206 with SMTP id e56mr3890461wec.19.1292312659017; Mon,
 13 Dec 2010 23:44:19 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Mon, 13 Dec 2010 23:43:48 -0800 (PST)
In-Reply-To: <4D071DAA.3070400@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163633>

On Tue, Dec 14, 2010 at 2:32 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 12/14/2010 6:32, schrieb Junio C Hamano:
>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>
>>> All paths should not exceed PATH_MAX, right?
>>
>> Your PATH_MAX may be a lot shorter than the PATH_MAX on the system I
>> created my trees on that you are reading.
>
> And that is not just gray theory: On Windows, PATH_MAX is whopping 260
> characters!

Does that mean Windows won't accept any path longer than that, or
PATH_MAX is defined just for fun?
-- 
Duy

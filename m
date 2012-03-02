From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Update l10n guide
Date: Fri, 02 Mar 2012 11:47:58 +0100
Message-ID: <4F50A55E.8040705@viscovery.net>
References: <CANYiYbGS_cFTHT1Pkafi9dmzedqezTq8k1tPkYur0b2St_c43Q@mail.gmail.com> <7v1upew6d0.fsf@alter.siamese.dyndns.org> <7vfwduujxw.fsf_-_@alter.siamese.dyndns.org> <CANYiYbE5rcnD_VGJyL2CjS-R5E0pyNSd5TetvH849W6wC5JiAA@mail.gmail.com> <7vk434q4eg.fsf@alter.siamese.dyndns.org> <CANYiYbE7bxz5=h9gaKf6+N6k5cn6mEKnuf_7KPFAnDrC31UL_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 11:48:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Q20-00043s-6z
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 11:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523Ab2CBKsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 05:48:06 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:39580 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab2CBKsE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 05:48:04 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1S3Q1m-000381-NW; Fri, 02 Mar 2012 11:47:58 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 5151E1660F;
	Fri,  2 Mar 2012 11:47:58 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <CANYiYbE7bxz5=h9gaKf6+N6k5cn6mEKnuf_7KPFAnDrC31UL_w@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192022>

Am 3/2/2012 8:30, schrieb Jiang Xin:
> Git does not handle multi-bytes character well. Multi-bytes characters
> not convert to UTF-8 when git write tree objects and commit objects.

It does not convert, but it records which encoding the text has. If you
don't specify anything, UTF-8 is assumed, and if your text is actually not
UTF-8, the result is necessarily garbage.

> I think allow multi-bytes characters in commit log would hurt git.git until
> git gives full support UTF-8 (are there any plans for this?).
> I just tested several versions of msysgit:
> 
>  - Only Git-1.7.8-preview20111229-unicode.exe saves commit objects
>    with utf-8 encode.
> 
>  - Other versions such as Git-1.7.9-preview20120201.exe and
>    Git-1.7.8-preview20111206.exe will not convert multi-bytes characters
>    in commit log into UTF-8.

Then you haven't set i18n.commitEncoding. Try this:

   git config i18n.commitEncoding CP936

(substitute whatever Windows codepage you are using).

-- Hannes

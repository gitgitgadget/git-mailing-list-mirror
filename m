From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: pull ref markes pull out of subject <a> tag
Date: Sun, 23 Aug 2009 15:31:22 -0700
Message-ID: <7vzl9qqi11.fsf@alter.siamese.dyndns.org>
References: <1251016089-10548-1-git-send-email-giuseppe.bilotta@gmail.com>
 <200908232213.48786.jnareb@gmail.com>
 <cb7bb73a0908231343k3546682ge05cc4f3c3d83638@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 00:31:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfLbG-0000bn-Sa
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 00:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbZHWWbi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Aug 2009 18:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbZHWWbh
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 18:31:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54254 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbZHWWbh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Aug 2009 18:31:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B85E16BE5;
	Sun, 23 Aug 2009 18:31:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=aLMz7fsMQesywU8aRxrzI7fMx
	qs=; b=KsPP0gdg66nzUtsI9L/stO2x6h5QuYg7Ff9I+7St6OXSvZ/0AAepRli1D
	i7ABY5f5ww1lZDF0gN/EGZNzejehMNSOewcdblSIiu/DhJH8kLr6LVKXFfS1Wfyl
	NScjpsDnm+fWOVzRP2nVpKbafgxheMpQA+EY3vmvf10KTWWXcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=psoekf8tIrtHDmPtAH9
	YVqkrpjM/2xSBP0JFt7qd56Oaldhe0jVxTjUYsdP1ocupQAiFheL3EdmYbXKV/uH
	H/yGxXec0MPRvKsxza9WsOUXfwAcMd0q9MznPCyuSGHu4HhD52C99C5K0idrgS3w
	5KdVWlWXDe7jdooEwHAkGWEg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 11C6216BE4;
	Sun, 23 Aug 2009 18:31:35 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5995B16BE2; Sun, 23 Aug
 2009 18:31:30 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B6FD3634-9034-11DE-B1C6-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126891>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> 2009/8/23 Jakub Narebski <jnareb@gmail.com>:
>> For format_subject_html which you are fixing, and which is used by
>> 'shortlog', 'history' and 'tags' views this didn't cause much change=
s
>> in layout. =C2=A0But the way gitweb uses git_print_header_div in vie=
ws such
>> as 'tree', 'blob' etc., where the outer (containing) link is made in=
to
>> *block* element[1] by the way of CSS (display: block) makes layout
>> (visualisation) very screwed up in older browser. =C2=A0But I don't =
expect
>> you to fix that.
>>
>> [1] Originally so the area to click is larger.
>
> Fixing that really needs some kind of ridiculously complex
> workarounds, or a totally different layout. That is actually one of
> the situations where nested links make perfect sense, and it's a real
> pity the standard wouldn't allow them, and that some client actually
> altered the DOM to 'fix' it. But anyway.
>
>> Signoff?
>
> Aaaargh. Is it enough if I put it here:
>
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

I can manage.

Thanks, both.

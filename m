From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH v2 2/3] strbuf: Add method to convert byte-size to human
 readable form
Date: Thu, 14 Aug 2008 20:53:59 -0400
Message-ID: <48A4D3A7.6080109@griep.us>
References: <1218752308-3173-1-git-send-email-marcus@griep.us> <1218752308-3173-2-git-send-email-marcus@griep.us> <1218752308-3173-3-git-send-email-marcus@griep.us> <20080814223429.GC10544@machine.or.cz> <7viqu3ci5k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 02:55:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTnay-0007Eg-0L
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 02:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbYHOAyJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 20:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751052AbYHOAyI
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 20:54:08 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:50068 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbYHOAyH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 20:54:07 -0400
Received: by wr-out-0506.google.com with SMTP id 69so805802wri.5
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 17:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=xhhOmbvlsM2xcb4Mrg2gRaZLP9u87KLuxDYzJ4irYjI=;
        b=jDKkKBc6C8g6r7ABk3DlCdwJGxfsSLDjEibzBYftzUQqqxyAJhFP9hwL0xe7iM1Fxw
         9W5LH33eZlRjAoKJGPF1hesbMI/MPczCSuDKgbW0YudkuuQ8VdP3Zdde/6fCmKni/cCT
         0ZLBrExrC0GlS6QQ5JbTwTlWkJ9fkE6VxwQKw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=YCt1FlPA5c228G3XzBxtXeQNdD1WYB/hBtYJG7Hmn15uC4ULQkqzUL4jLvze9+uExK
         V5IKkin8hF4tJ16m9hzf7NASjIUBkJAZKjitl9N7ModJv0BFrWyLgtGFJ0QMQZzhlez9
         DRYlXrJZYByTa33FMQ+EIplw4MjENR3z3ofNo=
Received: by 10.90.53.1 with SMTP id b1mr2763008aga.56.1218761645101;
        Thu, 14 Aug 2008 17:54:05 -0700 (PDT)
Received: from ?192.168.1.3? ( [71.174.65.78])
        by mx.google.com with ESMTPS id 10sm4579331wrl.11.2008.08.14.17.54.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 17:54:02 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <7viqu3ci5k.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92454>

Junio C Hamano wrote:
> 	960 bps
>         0.9 KiB/s
> 	2.3 MiB/s

A pedantic note, but bps is bits per second, whereas Bps or B/s is byte=
s
per second.  Requiring the same suffix for each would prevent some easi=
ly
overlooked issues like this.

> I also am not particularly happy about using "double" in this API.  M=
ost
> of the callers that gather stats in the rest of the codebase count in
> (long) integers as far as I can tell, and it may be conceptually clea=
ner
> to keep the use of double as an internal implementation issue of this
> particular function.

The function requires the use of a double for fractional parts, so lett=
ing=20
the compiler perform an upcast were necessary seems innocuous to me.

Also, Yibi-/Zibi-, unlikely to be used as they are, won't fit in a long=
=2E

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4

From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] add: refuse to add paths beyond repository boundaries
Date: Tue, 09 Apr 2013 20:58:44 +0200
Message-ID: <516464E4.10503@gmail.com>
References: <CALkWK0m_82ThYKxcr=YHGBnOaHr9yBpYFHxx2KrnQkWD_zjp1A@mail.gmail.com> <1365499297-8667-1-git-send-email-artagnon@gmail.com> <1365499297-8667-3-git-send-email-artagnon@gmail.com> <7v4nfftyu3.fsf@alter.siamese.dyndns.org> <7vvc7vsj4p.fsf@alter.siamese.dyndns.org> <51645EC6.407@gmail.com> <7v61zvsfkj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 20:58:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPdkr-0003I3-8E
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 20:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935706Ab3DIS6t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 14:58:49 -0400
Received: from mail-ea0-f172.google.com ([209.85.215.172]:56881 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759834Ab3DIS6s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 14:58:48 -0400
Received: by mail-ea0-f172.google.com with SMTP id z7so2970640eaf.17
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 11:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=aNDEn02aRMSMpLP2S29PkBpKS5a4/remLoo4mgCm+oQ=;
        b=HrcQlRMWcs0q4Gey9KW1PxDqJJwtMvuCo66LNcGVcOoh5sNShqkVYu3apsHqDcqCJk
         wL6x3SHU22Hi0pVcOO4he4g/7iiDim+CgNYT89aBn0tKqrhFI7nkMMgtXUKDph+KpF0f
         tz7W+fcjYnJWai5jHHJ7QOK9tYeM98FXZrwHLXg5vUD5vfO7EP2fu+8XNVu/JDf3uWXc
         X+3wlql2QEiN9+C+1yI5J7fX6CztS0jKG6vpEVRNDqPXPECFKfFuaCHXjvAFoSq4Vh5m
         RHDOsZM2mYKHMb2v5wUlcwYseErG9iGcT85S3TAtUUK3OAugXuMmcimHfJl35aq2uK+r
         mQyQ==
X-Received: by 10.14.216.2 with SMTP id f2mr62889620eep.44.1365533927222;
        Tue, 09 Apr 2013 11:58:47 -0700 (PDT)
Received: from [192.168.1.14] (dce9.neoplus.adsl.tpnet.pl. [83.23.56.9])
        by mx.google.com with ESMTPS id bj2sm14839044eeb.1.2013.04.09.11.58.45
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 11:58:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <7v61zvsfkj.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220616>

Junio C Hamano wrote:
> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>=20
>> W dniu 09.04.2013 19:34, Junio C Hamano pisze:
>>
>>> -	if (has_symlink_leading_path(path, len))
>>> -		return error("'%s' is beyond a symbolic link", path);
>>> +	if (path_outside_our_project(path, len))
>>> +		return error("'%s' is outside our working tree", path);
>>> =20
>>
>> Don't we lose important information here?  Or we shouldn't care?
>=20
> What important information is it?

That the cause is symbolic link (or other git repository, in the future=
).

--=20
Jakub Nar=C4=99bski

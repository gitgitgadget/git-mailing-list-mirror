From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] add a Makefile switch to avoid gettext translation
 in shell scripts
Date: Tue, 24 Jan 2012 12:13:14 -0800
Message-ID: <7vpqe83llx.fsf@alter.siamese.dyndns.org>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
 <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
 <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
 <CALxABCbaBmP6k5TYrYLCYm8oiv=9cF=N7_opSTKUnbkz5b-cwg@mail.gmail.com>
 <20120119195222.GA5011@blimp.dmz> <7v1uqq84es.fsf@alter.siamese.dyndns.org>
 <7vwr8i6prk.fsf_-_@alter.siamese.dyndns.org>
 <7vr4yq6poy.fsf_-_@alter.siamese.dyndns.org>
 <CALxABCaGMabTLcCiYLv31YCiVY4OK7yEr4KL6e-0UMttMjGA_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= 
	<avarab@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 21:13:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rpmk5-0003G9-El
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 21:13:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756235Ab2AXUNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 15:13:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38895 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756163Ab2AXUNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 15:13:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AA347ACA;
	Tue, 24 Jan 2012 15:13:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q6e1MiEMEV4tF2p7dc+78gfwbOQ=; b=CJndjH
	detXxv08c942RszPkYSMFI61BeYc+Bp/QtsTqA/0IsgAZgsMjwj9WodiuOI6m7xs
	A3yW5UxyWsN+ehQyqkOKoTNkzjWGmBGFexdalTE9iOnqdA5YQPZWVhNTgO7uB0ff
	tZplIqDKmvYUBCyvviXQWbt9UMoPjjlPTbzF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x62GKQLu5qwpZg6d9Vgy5NGkmIG3Cbik
	dYa+6BHegxkxxgKQfyoToBJh+jlAkKBatvWEKycb23aip4n5NvT7zwRGoNJnnQTH
	f97EcVBEQAyW9aglGv6xTmgJfOQxWKKzgFgfsgCk99YnwHa9gjJVtWYya0cebkM2
	IPDnCRVtc00=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5084A7AC9;
	Tue, 24 Jan 2012 15:13:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD95D7AC5; Tue, 24 Jan 2012
 15:13:15 -0500 (EST)
In-Reply-To: <CALxABCaGMabTLcCiYLv31YCiVY4OK7yEr4KL6e-0UMttMjGA_g@mail.gmail.com> (Alex
 Riesen's message of "Tue, 24 Jan 2012 21:00:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D97E40B2-46C7-11E1-8631-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189065>

> Amen :)

Thanks.

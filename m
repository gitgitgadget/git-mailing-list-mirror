From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-p4: add P4 jobs to git commit message
Date: Tue, 19 Apr 2016 14:09:10 -0700
Message-ID: <xmqqd1plz4p5.fsf@gitster.mtv.corp.google.com>
References: <0102015420a6c30a-f2da55c9-1fc4-4df6-860e-228c5305f617-000000@eu-west-1.amazonses.com>
	<xmqqshyi2yb7.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7-2mefGwfXRhvQZJFPD4QYAzZ1jYG82s6cnDzWVCiDS8w@mail.gmail.com>
	<xmqqfuuh35v5.fsf@gitster.mtv.corp.google.com>
	<CABEqOBxZkYTm7_m-Eeq-acN=Nse1vLGk8Gm44BihVGi27KaGiw@mail.gmail.com>
	<xmqq7fft32y9.fsf@gitster.mtv.corp.google.com>
	<CABEqOBwqW+BO4rtOx4ax35VacE4RZhpo_1pbqzTP_EGiSWasiQ@mail.gmail.com>
	<xmqqh9ex1lsy.fsf@gitster.mtv.corp.google.com>
	<CABEqOBxkHstqRHFUYF7=eComB-HwUGwi0tpWbhvUuKiny-=Vyw@mail.gmail.com>
	<CABEqOBxY61yObr0FeUxPYxc6C+xvde1LOS7zS_dHpBqwemJ+dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>,
	Roberto Tyley <roberto.tyley@gmail.com>
To: Jan Durovec <jan.durovec@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 23:09:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ascta-0000TV-N6
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 23:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983AbcDSVJO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 17:09:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65061 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753872AbcDSVJN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 17:09:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7ED64145AC;
	Tue, 19 Apr 2016 17:09:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uexbJYNV0POfmdISSTc0jJsxjMM=; b=mvQy00
	hwiTwPjJIFbScc0CNsd0vUiNPdQrMfngcOhC/6fq2lRtRuW5zGLss0drag92zboh
	6CQmRCFp1YnWQfeUPBMDF8UE/gfJn4QuAHfhieTKxZBt8BVICBGCszi/zPLh5Ui1
	HwZ6g3xmkwXqLieyMWeubVzNRm4sbir/vpiH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Km9CyLokp3rMwX6olIndlnub1ko3WtIe
	F1ZrD/b5RXH6UCqOOR2yh6juQySojT6M7iSyZVQ0tgtG+SpV2bWtrjs9ATuTkku6
	F3DJzhta9Ig64mIdWp3GdKhdlt79HZkGjx4mxtZxtzMx2XvIPsv1Ry2JMwvBRwhQ
	VlWxfNqn0V8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 779BA145AB;
	Tue, 19 Apr 2016 17:09:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EB4EE145A9;
	Tue, 19 Apr 2016 17:09:11 -0400 (EDT)
In-Reply-To: <CABEqOBxY61yObr0FeUxPYxc6C+xvde1LOS7zS_dHpBqwemJ+dQ@mail.gmail.com>
	(Jan Durovec's message of "Tue, 19 Apr 2016 22:28:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F6E6F62A-0672-11E6-B7C5-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291927>

Jan Durovec <jan.durovec@gmail.com> writes:

> On Tue, Apr 19, 2016 at 8:50 PM, Jan Durovec <jan.durovec@gmail.com> wrote:
>>> Any submitGit users?  I think it lets you throw multiple-patch
>>> series just fine.  In this case, you'd prepare a two patch series on
>>> a branch, 1/2 being the clean-up and 2/2 being the new feature, and
>>> if you give that branch to submitGit as a whole it should do the
>>> right thing, I'd imagine.
>>
>> Hm... I'll see what it does with a pull request that has 2 commits.
>
> Huh... seems that it works :)
>
> v3 sent in 2 parts

Thanks.

For a series this small it does not matter, but anything longer it
would be easier to review with a cover letter (i.e. [PATCH 0/N]).  I
do not know if submitGit lets us do that, though.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] t1500: avoid setting configuration options outside of tests
Date: Tue, 10 May 2016 11:02:31 -0700
Message-ID: <xmqqr3d9pz9k.fsf@gitster.mtv.corp.google.com>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
	<20160510052055.32924-5-sunshine@sunshineco.com>
	<CAPig+cTXOcUfO=EE5xhOjEgzSNtmhrD84PDMvVHX9hEmwuV==g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 10 20:02:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0BzU-0005ys-8C
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 20:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751579AbcEJSCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 14:02:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751288AbcEJSCf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 14:02:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B2121821E;
	Tue, 10 May 2016 14:02:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/GbRZGDpjYUTXNdkv6BSLPQ1toA=; b=nZjKpn
	ZWuUng53PVEalUyCuBX5T8QkMfmgmFF88/VEIO8orBgSMAnk/lyZUJksvz7p/UiQ
	W7eMqcxdTx3lrxX6bXIcAmoV2JH68BWiseVwFCWYzljKSNgxV66rmaqGxK0sNhvV
	M0rctqdF7mQVzCL9/Bxqro6TW+tZwjp4QXbCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cuHpqMj/j6g8K8ved0VmX7qkKAHFlak6
	PjRc7msJGPanPDzgq9ddkMpW8ftP8QC/KKG1Pjk412OCLzb0C3Fz/egxi4zOEwuY
	qPZ4Ih0LiXXrdTWQLTShiUgOOISI5CHBWp62mQVnlBMiXEuway9M0CZB9kRccK6i
	nzgUmF0IpsM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 92C431821D;
	Tue, 10 May 2016 14:02:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0C6AD18219;
	Tue, 10 May 2016 14:02:34 -0400 (EDT)
In-Reply-To: <CAPig+cTXOcUfO=EE5xhOjEgzSNtmhrD84PDMvVHX9hEmwuV==g@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 10 May 2016 02:34:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5F229D86-16D9-11E6-BD9A-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294167>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
>> @@ -6,15 +6,25 @@ test_description='test git rev-parse'
>> +       case "$bare" in
>> ...
>> +       u*) bare="test_unconfig $dir core.bare" ;;
>> +       *) error "test_rev_parse: unrecognized core.bare value '$bare'"
>
> Oops, this line lost its ;; at some point while refining the code.
>
>> +       esac
>> +

Strictly speaking, you do not have to have one.  I'll squeeze it in
anyways.

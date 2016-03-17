From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Code reorgnization
Date: Thu, 17 Mar 2016 10:48:54 -0700
Message-ID: <xmqq7fh10zcp.fsf@gitster.mtv.corp.google.com>
References: <20160317111136.GA21745@lanh>
	<CA+39Oz6jNwcyCQFiakh=Ech6p8UYRW9pn95e6cTGXf8nFcwwWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, git list <git@vger.kernel.org>
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Thu Mar 17 18:49:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agc2i-0004mj-0s
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 18:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933440AbcCQRtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 13:49:00 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63073 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933182AbcCQRs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 13:48:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 210CE4CF45;
	Thu, 17 Mar 2016 13:48:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GxOnm41zSqh5uYD18Adzc6l1OkU=; b=Jzq/k/
	h5ECWNFq3BfD6SMYDQBBFsZYsoDVYUzzXI+zZgQ6u9lSphpmjT9/6HiV1nGce84K
	Robr+fYoaFVwv4shlVqXT6Vf0lCOAettz91cgDRZJlQiuu2hD01xABM6r1qR55l8
	AEccvFMUS5x5R783LaEfm6w5oduwSZNdf0AMI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XacgPayKbQgAgBwAdfItjdc9Pfj8pBJA
	pIEYQkgYQ2EXbNSUkxJnXx1ftSp9/4i2NK9Q9Bqx6ODsLoCdjG9IqoT3jFnjOkTh
	D7ewGsImoPFehKpN7YzUmt4mtyogCGAIu1g/qDU2a1B1TSFvyUcJS99qGmNGWvHw
	NCiOzfFdpJI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 176584CF44;
	Thu, 17 Mar 2016 13:48:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8FCEB4CF43;
	Thu, 17 Mar 2016 13:48:56 -0400 (EDT)
In-Reply-To: <CA+39Oz6jNwcyCQFiakh=Ech6p8UYRW9pn95e6cTGXf8nFcwwWQ@mail.gmail.com>
	(Thomas Adam's message of "Thu, 17 Mar 2016 17:00:03 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 858C9D64-EC68-11E5-B548-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289130>

Thomas Adam <thomas@xteddy.org> writes:

> On 17 March 2016 at 11:11, Duy Nguyen <pclouds@gmail.com> wrote:
>> Git's top directory is crowded and I think it's agreed that moving
>> test-* to t/helper is a good move. I just wanted to check if we could
>> take this opportunity (after v2.8.0) to move some other files too. I
>> propose the following new subdirs
>
> I wonder whether previous discussions on this still count?  See:
>
> http://marc.info/?l=git&m=129650572621523&w=1

If you refer to ancient discussion, especially to a large thread
like that one, please spend a bit more time to summarize it.  It
is between one person spends a bit more time, and all others
independently go there and read.

The essense of the proposal [1] back then was to move all the source
file to src/, rename t/ to testsuite.  And I think [2] is a pretty
good summary of the common feeling back then that explains why the
proposal died out:

    Moving everything into src/ and calling it "organized" doesn't
    actually accomplish much other than perhaps making the README
    file more visible to newbs; things are _still_ a mess, just a
    mess with four more letters...

This round is slightly more organized, so many points the old thread
raised would not apply, I suspect.


[References]

*1* http://thread.gmane.org/gmane.comp.version-control.git/165720/focus=165748

*2* http://thread.gmane.org/gmane.comp.version-control.git/165720/focus=166019

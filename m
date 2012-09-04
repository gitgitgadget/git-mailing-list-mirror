From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout extra files
Date: Mon, 03 Sep 2012 19:55:56 -0700
Message-ID: <7vd322ebsz.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
 <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
 <7vsjayew50.fsf@alter.siamese.dyndns.org>
 <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 04:56:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8jJj-0001NW-CP
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 04:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756580Ab2IDC4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 22:56:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50183 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754484Ab2IDCz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 22:55:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C17C78F7E;
	Mon,  3 Sep 2012 22:55:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M4CMmaZiL11vc1UFDYvGkbnfJ1c=; b=ww0zcx
	qIuNUnnBeJ45g4VaZlDouMzyZX//C7tlEt+TkVsj63WeGaQizLXfm75yk60mlzjA
	SLxA2Gk48NZtcFG6xDvhwqiqlDSh1XvHZratWdX5qgnu29qriKbVTKs1nQR+fUvN
	q91chqrhWT557tbLAP1a8G4znYH3oMo0h9Zqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rvqKdBahy2m7ILhYcUL7vybV7ZJl7IxK
	XtfnMDxhqZ6iGUNv7BmykftNEAdQF/e1V2Koa/zHefe0h/9ujX3SY5TcnOPQSbs8
	7zeSNwFgjmmG+fb66Z+a1aIixAhsgrxunoTcxToPySXOZayK8PdWTmnTZhbtQyvn
	RHGg9kH99pg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF84C8F7C;
	Mon,  3 Sep 2012 22:55:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12B658F7B; Mon,  3 Sep 2012
 22:55:57 -0400 (EDT)
In-Reply-To: <CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 4 Sep 2012 08:49:10 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D624ADA-F63C-11E1-8038-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204717>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> For this particular scenario, I do not see anything offhand that is
>> unclear about the behaviour of Git in the documentation, even though
>> as you pointed out, if the user is unaware that the shell passes
>> globs unmodified when they do not match, it may lead to a confusion
>> like this.  I certainly do not want to do a full "introduction to
>> shell" in our documentation, but if adding a short sentence or two
>> helps to avoid confusion like this, I do not strongly object to it.

Perhaps like this?

 Documentation/git-checkout.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git i/Documentation/git-checkout.txt w/Documentation/git-checkout.txt
index 63a2516..e7272b6 100644
--- i/Documentation/git-checkout.txt
+++ w/Documentation/git-checkout.txt
@@ -360,20 +360,32 @@ mistake, and gets it back from the index.
 $ git checkout master             <1>
 $ git checkout master~2 Makefile  <2>
 $ rm -f hello.c
 $ git checkout hello.c            <3>
 ------------
 +
 <1> switch branch
 <2> take a file out of another commit
 <3> restore hello.c from the index
 +
+If you want to check out _all_ C source files out of the index,
+you can say
++
+------------
+$ git checkout -- '*.c'
+------------
++
+Note the quotes around '*.c'.  'hello.c' will also be checked
+out, even though it is no longer in the working tree, because
+the pathspec is used to match entries in the index (not in the
+working tree by your shell).
++
 If you have an unfortunate branch that is named `hello.c`, this
 step would be confused as an instruction to switch to that branch.
 You should instead write:
 +
 ------------
 $ git checkout -- hello.c
 ------------
 
 . After working in the wrong branch, switching to the correct
 branch would be done using:

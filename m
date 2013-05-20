From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 2/2] doc: command line interface (cli) dot-repository dwimmery
Date: Mon, 20 May 2013 10:55:46 -0700
Message-ID: <7v38thwn6l.fsf@alter.siamese.dyndns.org>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
	<1368964449-2724-3-git-send-email-philipoakley@iee.org>
	<20130519173924.GB3362@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>, GitList <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 20 19:55:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeUJO-0002Mu-RC
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 19:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755701Ab3ETRzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 13:55:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755457Ab3ETRzu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 13:55:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6627820759;
	Mon, 20 May 2013 17:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7sS2i5DmwIgHlsRQQ0Ww63YUO+M=; b=rDaR1h
	u9t10cnW3XQhovZ1m3s9nMQwd3++v8u4WsNJUyieyIT0hKlCmoonPdRjyV3nvIyz
	/nC+nKRAcFmn6kV48aCLLCeQ9P3HKCIVkCjfLNGXxRfGNSOlREMkwkDEZGJyya3d
	wY7lNI4/PTr6BOC7ABiF64fiiU4qKxraSmChE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WMK5Yg/0HKybp/3FIPvehnSgn+Af6cx3
	inVcK+no7cW9J4a5k7RUM2tDFRVOvRYaGlSwbZPQFlfamGdROKUNn8tcAsvh+c6y
	BI1iUynOEBanJ4X4jf9ofS5uW9dwpjRhsGElZNsENOhMcNX2uWvfYxhFt1y++Fn4
	3ZsX+idGD3Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A5F620758;
	Mon, 20 May 2013 17:55:49 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7178C20755;
	Mon, 20 May 2013 17:55:48 +0000 (UTC)
In-Reply-To: <20130519173924.GB3362@elie.Belkin> (Jonathan Nieder's message of
	"Sun, 19 May 2013 10:39:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80BD39A8-C176-11E2-8489-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224969>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> --- a/Documentation/gitcli.txt
>> +++ b/Documentation/gitcli.txt
>> @@ -59,6 +59,10 @@ working tree.  After running `git add hello.c; rm hello.c`, you will _not_
>>  see `hello.c` in your working tree with the former, but with the latter
>>  you will.
>>  
>> +Just as, by convention, the filesystem '.' refers to the current directory,
>> +using a '.' (period) as a repository name in Git (a dot-repository) refers
>> +to your local repository.
>
> Good idea, but I fear that no one would find it there.

Also I think it would be better without ", by convention,".  If you
say '.' == current directory is "a convention", you have to start
saying that "by convention", "hello.c" refers to the file in the
current directory of that name, which may be technically correct but
make the phrase "by convention" meaningless.  A dot "."  is *the*
name for the current directory, just like "hello.c" is the name for
that file.

    Just like '.' refers to the current directory in the filesystem, '.'
    refers to the current repository.

would be sufficient.

> Would it make sense to put this in Documentation/urls.txt (aka the
> "GIT URLS" section of git-fetch(1) and git-clone(1)), where other URL
> schemes are documented?

Yes, the '.' described above is a special case of giving a
repository URL as a relative-path on the filesystem.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Minor grammatical fixes in "git log" man page
Date: Mon, 11 Nov 2013 09:59:28 -0800
Message-ID: <xmqqd2m6n7jz.fsf@gitster.dls.corp.google.com>
References: <1383957130-2979-1-git-send-email-jstjohn@purdue.edu>
	<20131109010048.GG10302@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jason St. John" <jstjohn@purdue.edu>, git@vger.kernel.org,
	Marco Costalba <mcostalba@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 18:59:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfvlw-0002S8-Jm
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 18:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860Ab3KKR7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 12:59:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58700 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753572Ab3KKR7b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 12:59:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 168554F879;
	Mon, 11 Nov 2013 12:59:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DXa31b9Sqgp9kmQVCEUVtlwDgo8=; b=HZB4jC
	dJ/wvOJM4gamXFSa/yPyybebvitrppZc36LoMGfSyPvWHhyrqSP6Hyz7t8oazhCV
	1NUdiu5/E9wlf0VLAInrIFPM6xuHVMs3SXdOEoM8ui5osNpT2FJ87NKGAECV2Tgl
	NFWaWmzgx7ou4WWWBe3OsMbIjHLhq7NGFMmpo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qq8s8b3OCmXQSTghdOSB0YaUqoEAEuKw
	/Y0xkbleblV09H23UYr+0hnu7X7xkdFosPDBdvU5BB9uZ26rIRDD+SvmNYfTylQC
	BjGFURT0XP6b/ryzIBsesL+Gy97YBLnhxJlaBanefQMz8+eWzepRfAfgThvC60Ds
	ffdOrwRS1LI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 027F94F878;
	Mon, 11 Nov 2013 12:59:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5FD174F876;
	Mon, 11 Nov 2013 12:59:30 -0500 (EST)
In-Reply-To: <20131109010048.GG10302@google.com> (Jonathan Nieder's message of
	"Fri, 8 Nov 2013 17:00:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 034F47D6-4AFB-11E3-AE22-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237621>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jason St. John wrote:
>
>> git-log.txt: grammatical fixes under --log-size option
>
> Thanks.
>
> [...]
>> --- a/Documentation/git-log.txt
>> +++ b/Documentation/git-log.txt
>> @@ -56,10 +56,10 @@ Note that this affects all diff-based output types, e.g. those
>>  produced by --stat etc.
>> 
>>  --log-size::
>> -	Before the log message print out its size in bytes. Intended
>> +	Before the log message, print out its size in bytes. Intended

Either reads well at least for me.

>>  	mainly for porcelain tools consumption. If Git is unable to
>> -	produce a valid value size is set to zero.
>> -	Note that only message is considered, if also a diff is shown
>> +	produce a valid value size, this is set to zero.
>> +	Note that only message is considered. Also, if a diff is shown,
>>  	its size is not included.
>
> I have no idea what this option does, before or after the change.

The original is probably more accurate, if harder to read.  The
byte-size of the message part of log output is reported, so that
tools like QGit can slurp that many bytes and then treat the
remainder as a patch (if -p, --stat, etc. were given).

> Perhaps some of the above could make it into a clearer description?
> E.g.,
>
> 	--log-size::
> 		Include a line "log size <number>" in the output for each
> 		commit, where <number> is the length of that commit's
> 		message in bytes.  Intended to speed up tools that
> 		read log messages from 'git log' output by allowing them
> 		to allocate space in advance.

Yeah, that reads better. We do not have to single out "if also a
diff is shown", as there are other kinds of output that can follow
the message proper, and they are not counted.

> The commit introducing --log-size also says:
>
> 	    In case it is not possible to know the size upfront
> 	    size value is set to zero.
>
> Is this still true?  When is it not possible to know the size up
> front?

I have no idea ;-)  Perhaps Marco can enlighten us?

> The implementation of --log-size is
>
> 	if (opt->show_log_size) {
> 		printf("log size %i\n", (int)msgbuf.len);
> 		graph_show_oneline(opt->graph);
> 	}
>
> What happens if the commit message is long enough to overflow a 32-bit
> integer?  Is that impossible for other reasons?  If it is possible,
> (not about this patch) should this be using a 64-bit integer to print
> instead?

A nice low-hanging fruit ;-)

Thanks

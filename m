From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 10:30:02 -0700
Message-ID: <7vvcga96n9.fsf@alter.siamese.dyndns.org>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de>
 <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com>
 <004701cd771e$21b7cbb0$65276310$@schmitz-digital.de>
 <CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com>
 <01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de>
 <7v628epzia.fsf@alter.siamese.dyndns.org>
 <000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de>
 <7vy5l9lj6m.fsf@alter.siamese.dyndns.org>
 <001801cd7eee$24f95a50$6eec0ef0$@schmitz-digital.de>
 <7v4nnxld24.fsf@alter.siamese.dyndns.org>
 <002a01cd8083$69fb9960$3df2cc20$@schmitz-digital.de>
 <CA+sFfMdnixrUekh40Sde05tkap7Oj19=5D6J6aYVVD1krqPZkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	rsbecker@nexbridge.com
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 19:30:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Ekw-0002LK-KI
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 19:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510Ab2HVRaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 13:30:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53104 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964848Ab2HVRaG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 13:30:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A1EF9361;
	Wed, 22 Aug 2012 13:30:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xZJe0hNmQhIFhIaX9A+bFZuj9uQ=; b=mC/4sy
	JOCPTx680gvyyBVm4fFLo4nHPG3rjsiuMmjAkQPWUH2mrXgPWcH9/V6DQk55bL8B
	ISNhEgLDoU+5I9PC6LsSMSBOO9thISjbE5oCcnYMlm++biYo95kzzZ3V8CfYEmrp
	kK/jNoBr/dyL9/WeuqM3cugiqvrcecPrToevs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R+/hnCAtvuWEEPasX3nEOI7w6qDkFvpJ
	fJXnAWjCLByvST4TGF+OK08Z3peaGjvtjQF/obbvDa69tksESVGHQRUpo8xkP1xx
	22Ad0KuKm1rikzuFaXuQLJNKsCvTmzZ8mt5hIObc9xbzG1fPa3ZJN5VG/Ye3Hlup
	9CQeljhBMCA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 717D39360;
	Wed, 22 Aug 2012 13:30:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C8011935A; Wed, 22 Aug 2012
 13:30:03 -0400 (EDT)
In-Reply-To: <CA+sFfMdnixrUekh40Sde05tkap7Oj19=5D6J6aYVVD1krqPZkw@mail.gmail.com> (Brandon
 Casey's message of "Wed, 22 Aug 2012 10:00:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 021D0DE8-EC7F-11E1-B03F-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204041>

Brandon Casey <drafnel@gmail.com> writes:

> On Wed, Aug 22, 2012 at 9:30 AM, Joachim Schmitz
> <jojo@schmitz-digital.de> wrote:
>
>> OK, so how about this:
>> /usr/local/bin/diff -EBbu ./compat/mkdir.c.orig ./compat/mkdir.c
>> --- ./compat/mkdir.c.orig       2012-08-21 05:02:11 -0500
>> +++ ./compat/mkdir.c    2012-08-21 05:02:11 -0500
>> @@ -0,0 +1,24 @@
>> +#include "../git-compat-util.h"
>> +#undef mkdir
>> +
>> +/* for platforms that can't deal with a trailing '/' */
>> +int compat_mkdir_wo_trailing_slash(const char *dir, mode_t mode)
>> +{
>> +       int retval;
>> +       char *tmp_dir = NULL;
>> +       size_t len = strlen(dir);
>> + ...
> Why not rearrange this so that you assign to dir the value of tmp_dir
> and then just pass dir to mkdir.  Then you can avoid the recast of dir
> to (char*) in the else branch.  Later, just call free(tmp_dir).  Also,
> we have xstrndup.  So I think the body of your function can become
> something like:
>
>    if (len && dir[len-1] == '/')
>        dir = tmp_dir = xstrndup(dir, len-1);
>
>    retval = mkdir(dir, mode);
>    free(tmp_dir);

Nice.  And we have xmemdupz() would be even better as you
followed-up.

Thanks.

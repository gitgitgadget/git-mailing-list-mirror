From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/5] command-list.txt: prepare with [commands] header
Date: Fri, 15 May 2015 13:44:05 -0700
Message-ID: <xmqqmw15fu5m.fsf@gitster.dls.corp.google.com>
References: <1431714904-16599-1-git-send-email-sebastien.guimmara@gmail.com>
	<1431714904-16599-2-git-send-email-sebastien.guimmara@gmail.com>
	<xmqqr3qhfuz3.fsf@gitster.dls.corp.google.com>
	<5556582C.3010409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?S=C3=A9bastien?= Guimmara <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 22:44:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtMSt-0001Th-TA
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 22:44:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423036AbbEOUoK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2015 16:44:10 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:35983 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422661AbbEOUoI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 16:44:08 -0400
Received: by iepk2 with SMTP id k2so129873750iep.3
        for <git@vger.kernel.org>; Fri, 15 May 2015 13:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=MDyxDZU/FF1X1w2wJWZMni6Hb+O98ORYIUNuGrgAyTg=;
        b=GtT3D3Vpo3CzMqMryfKuGrWSM6wxNs/gUMTNNVqIUIU74yOt8TU7/RZvLlGB/xSXS+
         ouM7bphoeazbB/cheFrkGu8irpgyejxiRLiAl5dounNzMFexf1Af5HoSKNJCREy4qawJ
         Wayxc4oQ+jJRnZAY6hFv6jE6jSBFvRbB0pRrR6+/RcLMrVEEk1HZyra/VSWA01TVS+OM
         1RfTF8jr1SzlxT1Eg3TAIegWLE3Ic1+qdBj5x8Buu27BIjY/gO3EmZ8JJeWsqyB4ZEi/
         3BwOXpnOCe+3Rzbhkyc+vK8Vire65hRFi6NBHWQ4WwlEz0pNIr0TB724QG1e+Mwn4LGD
         7g0g==
X-Received: by 10.107.130.17 with SMTP id e17mr15137542iod.80.1431722647242;
        Fri, 15 May 2015 13:44:07 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1148:d596:44de:a92d])
        by mx.google.com with ESMTPSA id n9sm2378560igy.2.2015.05.15.13.44.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 15 May 2015 13:44:06 -0700 (PDT)
In-Reply-To: <5556582C.3010409@gmail.com> (=?utf-8?Q?=22S=C3=A9bastien?=
 Guimmara"'s message of
	"Fri, 15 May 2015 22:33:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269181>

S=C3=A9bastien Guimmara  <sebastien.guimmara@gmail.com> writes:

>> This is largely just a "taste" thing, but with all these backslashes
>> in the supporting infrastructure you had to add in Makefiles and
>> scripts, don't you think the choice of the way you designed the
>> format to use '[commands]' was a rather poor one?  After all, all
>> you need is a clear separator line for a block of commands and
>> another block of groups, and there wasn't a reason why you needed to
>> use square brackets for that, and the sed scripts are suffering from
>> that poor choice.
>>
>> You could for example have used the existing "# List of known git
>> commands" as such a signal to tell that all the no comment lines
>> below are commands.
>
> I tend to think that relying on comments as marks for parsers is brit=
tle,
> but indeed square brackets get in the way of sed regexes. I'll think =
of
> something better. Thanks.

Heh, we, and more importantly our users, already rely on a marker in
comments when writing their commit log messages ;-)

I would not be opposed to a new header that is outside comment, but
I do not think the marker line that is also a comment is "brittle"
and would not be opposed to that, either.

    # do not molest the next line
    ### command list
    # name category
    git-add mainporcelain
    ...

would be perfectly acceptable.

I was just pointing out that you did not even have to have patch
1/5.

Thanks.

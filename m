From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 00/12] ref-filter: use parsing functions
Date: Tue, 2 Feb 2016 10:05:49 +0530
Message-ID: <CAOLa=ZTnCq1QCByj9vN9SzihNv5uYFnxJ1_qhMfY=UTSFQ7wFQ@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
 <xmqqr3gwt6dp.fsf@gitster.mtv.corp.google.com> <CAPig+cTT2Ti5r73=ndF5uR6ovGi16PcYEBb89ik0rcYTVZiRDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 05:36:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQShV-000777-2N
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 05:36:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbcBBEgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 23:36:20 -0500
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34325 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbcBBEgU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 23:36:20 -0500
Received: by mail-vk0-f48.google.com with SMTP id e185so89662135vkb.1
        for <git@vger.kernel.org>; Mon, 01 Feb 2016 20:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hGRKCmESkw/L83KHvaU0VfpzM/FsccI+0h7lwi/Udfk=;
        b=XG3N8ZxFHTFV/mlpefwWeyYcmuLvR78rNehKJZCowv480a2XJYAblGMXoYB2rQF/Hl
         ilElQcx5Ohf2H8gWyGm1dhVaWZwwPKT8HcEQwy+XalvcodPK+YcdHPv09cT0FeWlAPt5
         h+wrcxO6WkdozcdBXNV74Qelr/agaVAdmc9pwf5J4QfGiCPXF8drLppqhWtGNwfSUSdl
         kIydhJFJiCmn7Ti1Bt0P8YtOXQYNtX9kEyg0jXFXk2Whe+Ac+qV5D1bBCG3JI8lk7RfX
         Va1mRNyVQjeDXwC2EBJCex3DnvgDj7ERJjsWHmB4P4KW5LJ3mlWvVwcVK9gj4JZXmqNK
         i5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=hGRKCmESkw/L83KHvaU0VfpzM/FsccI+0h7lwi/Udfk=;
        b=RnQagXu+OycSJldDnGmZrkH4RzvQaXTcpK+/98GWPOhQ5lvhEP/fXePxz1H7L/SMQE
         PUHDyhrFCna+xTyGpvkQEzf4xaXQQsoMRqE0ixc5T6vf/KsYywSiOEKjCKA3K0N4QGwd
         APkzXOnWTa1HW5wxjZ5BgAsm8aTCmmXad4GeloqcYKPuSlwMe6hFpD+VDqKLtqqYoFRl
         VDuOKrNGrkGOwzsmcRuuDGFE+ALPxFGKR8DRA/4IKnL8+rhPKTEQEBdZDVmxOqImN53o
         L2VmKlR/5wkM++Z9v67aq6lFUQqh32bxVPV+WyOTf8W9/XPFJS+hvzkcH9vaXOMJU5EH
         vaVQ==
X-Gm-Message-State: AG10YOQwMephKiUuFfyo7VrLJ36xMqXU4aJQjjmxGb5nO2ooGlPkYq5ksXOwJSiN6vhyMxJr0Ek+fMvL4KnlYQ==
X-Received: by 10.31.142.203 with SMTP id q194mr18075524vkd.95.1454387779090;
 Mon, 01 Feb 2016 20:36:19 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Mon, 1 Feb 2016 20:35:49 -0800 (PST)
In-Reply-To: <CAPig+cTT2Ti5r73=ndF5uR6ovGi16PcYEBb89ik0rcYTVZiRDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285236>

On Tue, Feb 2, 2016 at 6:07 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Feb 1, 2016 at 5:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> This series cleans up populate_value() in ref-filter, by moving out
>>> the parsing part of atoms to separate parsing functions. This ensures
>>> that parsing is only done once and also improves the modularity of the
>>> code.
>>>
>>> v1: http://thread.gmane.org/gmane.comp.version-control.git/281180
>>> v2: http://thread.gmane.org/gmane.comp.version-control.git/282563
>>> v3: http://thread.gmane.org/gmane.comp.version-control.git/283350
>>>
>>> Changes:
>>> * The parsing functions now take the arguments of the atom as
>>> function parameteres, instead of parsing it inside the fucntion.
>>> * Rebased on top of pu:jk/list-tag-2.7-regression
>>> * In strbuf use a copylen variable rather than using multiplication
>>> to perform a logical operation.
>>> * Code movement for easier review and general improvement.
>>> * Use COLOR_MAXLEN as the maximum size for the color variable.
>>> * Small code changes.
>>> * Documentation changes.
>>> * Fixed incorrect style of test (t6302).
>>>
>>> Karthik Nayak (12):
>>>   strbuf: introduce strbuf_split_str_omit_term()
>>>   ref-filter: use strbuf_split_str_omit_term()
>>>   ref-filter: bump 'used_atom' and related code to the top
>>>   ref-filter: introduce struct used_atom
>>>   ref-filter: introduce parsing functions for each valid atom
>>>   ref-filter: introduce color_atom_parser()
>>>   ref-filter: introduce parse_align_position()
>>>   ref-filter: introduce align_atom_parser()
>>>   ref-filter: align: introduce long-form syntax
>>>   ref-filter: introduce remote_ref_atom_parser()
>>>   ref-filter: introduce contents_atom_parser()
>>>   ref-filter: introduce objectname_atom_parser()
>>
>> Hmm, 10/12 didn't make it to the list?
>
> Not surprising. Somehow, Karthik did git-add on the compiled
> test-fake-ssh before committing, so the patch sent to the list
> contains an rather huge binary resource. I did receive it since I was
> a direct addressee of the email; I'll reply to the message on-list
> without modifying anything (other than stripping out the binary
> resource) so that other reviewers get a chance to see it.

Thanks Eric, i didn't notice doing that.

-- 
Regards,
Karthik Nayak

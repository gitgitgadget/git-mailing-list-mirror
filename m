From: Stefan Beller <sbeller@google.com>
Subject: Re: sb/submodule-parallel-fetch,
Date: Mon, 14 Dec 2015 11:37:05 -0800
Message-ID: <CAGZ79kaD5vtrofHmeWyKEDiNMSuuCfwwHHie8O03PdjQRK_V=A@mail.gmail.com>
References: <xmqqmvthhqgf.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaA6Lo1W-SudX6v5styyGrX-igGC7i=u5AYOvFYK0DOGA@mail.gmail.com>
	<xmqqvb85g8v9.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY8M-Xv1s4-s7HnjxZ_X19SR4PsWMtQ3yogqN=vjDiMwQ@mail.gmail.com>
	<566B4207.8020009@kdbg.org>
	<CAGZ79kYOtoWHCzpeHGrCEjTUuKYB3rogfV2dxL_TL5Pcu59RSg@mail.gmail.com>
	<xmqqvb84d1p1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 20:37:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Yvr-0002fA-0R
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 20:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975AbbLNThI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 14:37:08 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:33950 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801AbbLNThH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 14:37:07 -0500
Received: by ioae126 with SMTP id e126so55611937ioa.1
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 11:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bNNIQ9gesxool3LuQVujN7B7uOppScOFdJF0j3vPCgA=;
        b=eX5GumJfTLZ+UQtlZGKAmxMiI5yMu7J47mz8Sdo28M8F4fEZ3Zcm/OBFMEyPUCdKdP
         UmOdr4u2Hs4olo1m9t1smLn8GgBu2skxiZguBWxkvG5R/GKdhdhqkPsk2nRT3d3gpn2Z
         pkjWz/YdS1MAO+jCwGw0rOUdP8lVZkEYqj/4a2bxyYAtcx7THm1FnGG7Te2g8uYo15hu
         68ZDOm4w0vOhUHP4+f1OMA0oxMVpbx8sNApUCQiSAzgnBb3QK79JdFMKQIuCGs1N0Fve
         773N3WLlBQf8ILXO0tA/+fAxSM73DqH/Ob/tdQFrpVfdKq3atUj44g7Wjr5pZGIadjbm
         K6OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bNNIQ9gesxool3LuQVujN7B7uOppScOFdJF0j3vPCgA=;
        b=Nwb83H6gRQ55kuMlHK4ZNy/GhmP4VyOFFG97j/Rez0fgTNo+y+zhRzCpjzzTTu69Df
         YwUvU0yQvHtyO7iSqRTe/1dSH9z/Gje+tZX+CaHBnx2Yll6OQ194iL2gHKnF6ky5uyl0
         CYICMHj7AnND9RcIRJ3hF9Ss2zaAm3rpRifB+F1VK3gq0oPncB1llloZrg7fUOYNZOC+
         1DbAJlXQNzdzfpbHYcmCvOu2TViBnZryT1KRqVFLjjZX5PIYNtftYXpYpAqatCTklcLV
         S5fnYfDkJSq8QZlpFV0KmLVg0r/kXwZ5RLEV7htqxPmQ1wU7GESaxk3oo7cyuZ00QcYJ
         jlBw==
X-Gm-Message-State: ALoCoQnqNMVXFS1ljqL02CBHqYvY51sGJaW3axXUnA++q587rWNlUc5kYjjISwSPU0RX8wQlO9cS7H78/KWIC7ho9XlAQl2O3q7ygnz5ovXSHbOoiqg9ZRQ=
X-Received: by 10.107.129.149 with SMTP id l21mr420167ioi.174.1450121825631;
 Mon, 14 Dec 2015 11:37:05 -0800 (PST)
Received: by 10.107.8.84 with HTTP; Mon, 14 Dec 2015 11:37:05 -0800 (PST)
In-Reply-To: <xmqqvb84d1p1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282385>

On Fri, Dec 11, 2015 at 3:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Fri, Dec 11, 2015 at 1:37 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>>>
>>> Generally, I'm already quite satisfied with the state of the
>>> infrastructure at the tip of the branch.
>>
>> I was about the rework the patch series.
>
> OK.
>
> I think the very early part of the series, up to 8fc3f2ee (sigchain:
> add command to pop all common signals, 2015-09-30), may be fine
> as-is (i.e. just rebase on top of updated 'master').

I did that.

>
> The step after that, i.e. asynch processor, is the most interesting
> and important one.  Since it was written, I think the improvements
> that we want to be rolled into it from the beginning are:
>
>  - do not rely on waitpid(-1);

and documented in the commit message why we abandoned that
implementation.

>
>  - no need for set_nonglocking(), squashing a4433fd4a and
>    6f963a895a9 in;

6f963a895a9 (strbuf: update documentation for strbuf_read_once())
squashed into a commit before your anticipated "very early part
which  may be fine as is", but no worries.

>  - correct the early-shutdown bug 79f38577 and again in 63ce47e1;
>
>  - child_process_clear() in 1c53754a, which probably will become
>    unnecessary if the series is rebuilt on top of updated 'master';

it did.

>
>  - follow-up fixes and enhancements to the tests in c3a5d11 and
>    74cc04d;
>
>  - debugging support in 7eb93e91069 (from the other series that
>    builds on top).

not just cherry picking that one, but also adapt the tests in this series to
use it.

>
> That would slim down not just the total number of patches, but also
> the amount of the code that needs to be looked at (as we would not
> add code only to later remove or fixup).

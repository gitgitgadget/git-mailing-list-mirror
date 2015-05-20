From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] mergetools: add winmerge as a builtin tool
Date: Wed, 20 May 2015 13:03:36 -0700
Message-ID: <xmqq1tibnhif.fsf@gitster.dls.corp.google.com>
References: <1432107722-98613-1-git-send-email-davvid@gmail.com>
	<CAHGBnuMCvzBYRYgLxz-5QJ5x8Quhw6byf+cGteRXQzpU65B+Jg@mail.gmail.com>
	<20150520085346.GA99001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Phil Susi <phillsusi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 22:04:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvADS-0007zU-0Y
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 22:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754524AbbETUDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 16:03:41 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:36151 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471AbbETUDi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 16:03:38 -0400
Received: by iepj10 with SMTP id j10so47847232iep.3
        for <git@vger.kernel.org>; Wed, 20 May 2015 13:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=UBifnLgNf+TC79KJTjsyfV4rDVEfDND3vhc7QGQuDvM=;
        b=oWnsyPErdLxUCE9MSE9BqMBFgFLGoTiyEARuz4x56OhCPeVRzwcLM8tZVz9MpdME8T
         WkC18pAqVMn4Kyr01uhW3LtH1JxQiDc5zHqUssQ5MkE4aaOvDoauum+9AiTp3w2JMmad
         y6WXnsqQmJArEWo+iNX4EqnUSfqq1YfBN088gFhnqwyosuu/gUQhaM2fvwxlnmlf4vUQ
         bacJ5Lcv3cNv2jg/4rcYekcnZdP8T6BDPtqkEC6Or0nHRx6kVWUakggHkQouLKTUMdhz
         tdBCU8H+Mxa68qjdvldT0KKwPEKWguVOeMTAosxSs6huhfMAo0vqWqyan0sUNbpolTt3
         58EA==
X-Received: by 10.50.13.10 with SMTP id d10mr30734494igc.20.1432152218220;
        Wed, 20 May 2015 13:03:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6ddd:2b37:d23b:a593])
        by mx.google.com with ESMTPSA id p8sm2325446iga.13.2015.05.20.13.03.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 13:03:37 -0700 (PDT)
In-Reply-To: <20150520085346.GA99001@gmail.com> (David Aguilar's message of
	"Wed, 20 May 2015 01:53:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269513>

David Aguilar <davvid@gmail.com> writes:

> On Wed, May 20, 2015 at 09:47:56AM +0200, Sebastian Schuberth wrote:
>> On Wed, May 20, 2015 at 9:42 AM, David Aguilar <davvid@gmail.com> wrote:
>> 
>> > +       OIFS=$IFS
>> > +       IFS='
>> > +'
>> 
>> I guess this is just a formatting issue with the mail export as it should read
>> 
>> IFS=$'\n'
>> 
>> Otherwise looks good to me.
>> 
>> -- 
>> Sebastian Schuberth
>
> Thanks for the review.
>
> That's actually a literal newline inside a single-quoted string.
>
> I'm not sure how portable $'\n' is, but the '<literal-newline>'
> approach is used often in the git code.

Thanks for being observant ;-)  Unless it is contrib/completion that
is known to be run with bash, please avoid $'string' and $"string".

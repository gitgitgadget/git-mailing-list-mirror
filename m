From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sun, 08 Sep 2013 02:17:47 -0400
Message-ID: <522C168B.7050300@bbn.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com> <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com> <CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com> <xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com> <20130904081047.GB2582@serenity.lan> <xmqqa9jso69u.fsf@gitster.dls.corp.google.com> <7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley> <xmqqr4d4jird.fsf@gitster.dls.corp.google.com> <CAMP44s0kMbXvcJbWvJDu=8A5iOeH4fsMGUdT-ehXKNXiV1FQ1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 08:17:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIYJq-0007q9-K3
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 08:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539Ab3IHGRz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 02:17:55 -0400
Received: from smtp.bbn.com ([128.33.1.81]:43834 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473Ab3IHGRy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 02:17:54 -0400
Received: from socket.bbn.com ([192.1.120.102]:42476)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VIYJh-000PWw-0p; Sun, 08 Sep 2013 02:17:49 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 2F7743FF89
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <CAMP44s0kMbXvcJbWvJDu=8A5iOeH4fsMGUdT-ehXKNXiV1FQ1Q@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234190>

On 2013-09-07 22:41, Felipe Contreras wrote:
> On Wed, Sep 4, 2013 at 5:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
>> Which can be solved by adding the above "fail" option, and then
>> renaming them to "pull.integrate" and "branch.<name>.integrate" to
>> clarify what these variables are about (it is no longer "do you
>> rebase or not---if you choose not to rebase, by definition you are
>> going to merge", as there is a third choice to "fail"), while
>> retaining "pull.rebase" and "branch.<name>.rebase" as a deprecated
>> synonym.
> 
> All these names are completely unintuitive. First of all, why
> "integrate"? Integrate what to what? And then, why "fail"? Fail on
> what circumstances? Always?
> 
> My proposal that does:
> 
>   pull.mode = merge/rebase/merge-ff-only
> 
> Is way more intuitive.

+1

What about something like:

    pull.mergeoptions (defaults to --ff-only)
    pull.rebaseoptions (defaults to empty?  --preserve-merges?)
    branch.<name>.pull.mergeoptions (defaults to pull.mergeoptions)
    branch.<name>.pull.rebaseoptions (defaults to pull.rebaseoptions)

-Richard

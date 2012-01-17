From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git grep doesn't follow symbolic link
Date: Tue, 17 Jan 2012 08:55:28 +0700
Message-ID: <CACsJy8B9AGuRSx_5P22TOsqrA1rTEjQb78NN7PcTuK53iUmP_w@mail.gmail.com>
References: <CAPRVejc7xND_8Y=Pb5rYGEcaKYUaX7_WkSro-_EL8tTGxkfY3Q@mail.gmail.com>
 <CALkWK0=-LZH4MYhX50v-RWpGA2r+6q50YxsKaOxc0mJ__yuK7g@mail.gmail.com>
 <877h0zlvwd.fsf@thomas.inf.ethz.ch> <7vwr8za04q.fsf@alter.siamese.dyndns.org>
 <CACsJy8BfvhWxqBOj=+7AiF8dZBVEASAuxiOsjOvpmfE3uPrO3A@mail.gmail.com>
 <7v1ur1yazf.fsf@alter.siamese.dyndns.org> <CACsJy8CaBAEJo_LuvjYhb2kfofH83cbR5DFDffmmCU3uJFqk+g@mail.gmail.com>
 <7vwr8ruv1j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pang Yan Han <pangyanhan@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Bertrand BENOIT <projettwk@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 02:56:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmyHl-0002ki-L0
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 02:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049Ab2AQB4R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 20:56:17 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:54557 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab2AQB4A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 20:56:00 -0500
Received: by bkas6 with SMTP id s6so1137526bka.19
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 17:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ppXQ47JC6m97HutRcyndLluebch2kQg1i8cR0DN4Z9E=;
        b=ShPDnnUZXf6OYElmnx+0J01GzMiIfVbfBd4BQoQIUo0z0rEZON3WJsE8dhNMJxoTRp
         PF0K0bnF2UJnBk6E1e5VKjHuCaIfFUM0YwuX5eErFPQ9gWl/L2layqME2cACVVQO3KUv
         Csaka8nYIdnnN1AdpAzWXZgsGvBs+gLmM2lRE=
Received: by 10.205.132.14 with SMTP id hs14mr6028692bkc.130.1326765359158;
 Mon, 16 Jan 2012 17:55:59 -0800 (PST)
Received: by 10.205.123.145 with HTTP; Mon, 16 Jan 2012 17:55:28 -0800 (PST)
In-Reply-To: <7vwr8ruv1j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188680>

On Tue, Jan 17, 2012 at 5:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> It's not wrong per se. It's an implication that users have to take
>> when they choose to use it. We may help make it clear that the
>> symlinks point to untracked files by putting some indication in the
>> diff.
>>
>> When I do "git log -Sfoo -- '*.cxx'" I don't really care if bar.cxx is
>> a symlink. Neither does my compiler. It may be a symlink's target
>> change that makes "foo" appear. Git could help me detect that quickly
>> instead of sticking with tracked contents only.
>
> As there is nothing in Git that tells that whatever is pointed at by
> bar.cxx that happens to be in your filesystem today had "foo" in it when
> that historical version of the commit whose bar.cxx symlink was updated to
> point to that file. It is *WRONG* to show the commit as something that
> changes bar.cxx to contain "foo" (or more precisely, changes the count of
> "foo" in it).
>
> Why is it so hard to understand?

OK resolving links to untracked contents is bad and should only be
supported in --no-index case, resolving links to tracked contents
should be ok in principal? (I'm not sure how messed up diff code could
be with these changes)
-- 
Duy

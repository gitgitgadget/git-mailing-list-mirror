From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [RFC] git rm -u
Date: Mon, 25 Feb 2013 19:54:36 +0100
Message-ID: <CALWbr2x9=+PEaGTpGWoqGiiupGsPhLoPcGknPb1WtSgxdpBkdQ@mail.gmail.com>
References: <50FB1196.2090309@gmail.com>
	<1358632037-ner-2564@calvin>
	<CALWbr2zhxkZEGWc5iN-8MivzV7viEdfwV_Q-iH0xSUWkwnSmyQ@mail.gmail.com>
	<50FB1673.8020808@gmail.com>
	<7vzjys28a0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 19:55:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA3Cb-0001k1-7N
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 19:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758825Ab3BYSyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 13:54:40 -0500
Received: from mail-qa0-f48.google.com ([209.85.216.48]:38943 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758108Ab3BYSyj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 13:54:39 -0500
Received: by mail-qa0-f48.google.com with SMTP id j8so1784220qah.0
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 10:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=t7Gpr86NH3/qd3xY7iPwAOKrOMm7yHrEZuFqNLJUhJc=;
        b=hcWkX/KYq9MHpBAMMRTN1PSCgLd3C008sh3E5I7IEJlzEF0Fo9HPM9ck78r3epC4xX
         dcZd5pjoAOcQ1iFeqJhrY/8ngHP/jqy9ZebBgn37AnczZ2VgRwKVhdIW7+i2gnvO3HEp
         QR9R/wy4QdZX+nH09TWPagFSOQdoRf9HS0XF2ugxBUHMtl9LepAoaoJ+u+N4USFD4T9G
         k6qFG7Lruj2P+usWBWf1R8X9T6f8BQZYyk7cgN5pC9f3Pdmb6pJAFoOlkDjcvIYj++Hj
         oOnwHxshS9+F4Dh0IPCKLZPxKvZuiO2JRl2jIKl7i/uUPF8EFdkrTs8bLOxlaw+wY3Zr
         tNEg==
X-Received: by 10.49.62.42 with SMTP id v10mr15196130qer.2.1361818476795; Mon,
 25 Feb 2013 10:54:36 -0800 (PST)
Received: by 10.49.70.163 with HTTP; Mon, 25 Feb 2013 10:54:36 -0800 (PST)
In-Reply-To: <7vzjys28a0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217082>

I must say that I'm not very interested in the feature. In my opinion,
there are already many different ways to stage changes.
Assuming that the feature would be needed, I would keep it under the
scope of git-add, as it's the reference for staging. I would suggest
something like:

    git add -r   "Stage removal of deleted files."

On Mon, Feb 25, 2013 at 7:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric James Michael Ritz <lobbyjones@gmail.com> writes:
>
>> On 01/19/2013 04:49 PM, Antoine Pelisse wrote:
>>> I think `git add -u` would be closer. It would stage removal of
>>> files, but would not stage untracked files.  It would stage other
>>> type of changes though.
>>
>> On Sat, Jan 19, 2013 at 10:47 PM, Tomas Carnecky
>>> Does `git add -A` do what you want?
>>
>> Thank you Tomas and Antoine.  Both of these commands do what I want:
>> stage deleted files on the index.  But does the idea of a `git rm -u`
>> still sound useful since these commands also stage changes besides
>> deleted files?
>
> Even though I am not sure how often I would use it myself, "reflect
> only the removals in the working tree to the index, but exclude any
> other kind of changes" might turn out to be a useful addition to the
> toolchest in certain cases.
>
> I however am not yet convinced that "git rm -u" is a good way to
> express the feature at the UI.  "git add -u" is "update the index
> with modification and removal but ignore new files because we won't
> know if they are garbage or assets".  What the same "-u" option
> means in the context of "git rm" is not very clear, at least to me.
>
>

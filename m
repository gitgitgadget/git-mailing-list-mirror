From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: FETCH_HEAD question
Date: Tue, 17 Feb 2009 02:41:15 -0500
Message-ID: <76718490902162341y2f122427i470c77d3915ff554@mail.gmail.com>
References: <76718490902162043k78e615b5g7ba4b7ac95e73b18@mail.gmail.com>
	 <7veixxaale.fsf@gitster.siamese.dyndns.org>
	 <76718490902162221i31e02052j48c9f620a2d47985@mail.gmail.com>
	 <7vr61x8ra4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 08:42:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZKbO-0000YF-TX
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 08:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbZBQHlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 02:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbZBQHlT
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 02:41:19 -0500
Received: from rv-out-0506.google.com ([209.85.198.235]:46905 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbZBQHlS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 02:41:18 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1907645rvb.1
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 23:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PHPdiEoAtkfQoOrWZAndEYIYwgqJe1VNbag8DoyV8Mc=;
        b=mrA9XEzRkDwGVqKCi62lU31m1RwOY5dJagl/xzwWRxERl1pC08v02Dqbah523AoLYK
         iGRreV+4oQLT4Zntp6THZtROCJQH0gbWmymtwRALvYLlie04bqj9EZvxtpkRu3YzHuBy
         PZdfWVFdjEHx8/rDZWZuFANMmT7eza7lo/USo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=la0wc0tb+kTafysXv5x/sG7r7G8sGjmh9F1/8WQ2e07qdnqBm8xsbv/S13wW5aes9i
         8TNEtt76tUQOtw2zY+tWG8m1cLNyznZ62WoO91fKbZxHfwqg3hHMm9vV6/5/5ify2H7N
         1v6PAXAbEg9ZbA9BtgLhbPk6T5KOLwF84FUGg=
Received: by 10.141.194.21 with SMTP id w21mr2760759rvp.256.1234856475857; 
	Mon, 16 Feb 2009 23:41:15 -0800 (PST)
In-Reply-To: <7vr61x8ra4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110323>

On Tue, Feb 17, 2009 at 2:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Because it is designed to handle a lot more general case of fetching all
> remote branches into your remote tracking branches with wildcard refspecs,
> and most of the entries need to be marked with not-for-merge marker.  If
> you left only the for-merge branches, you would not have any sane way to
> learn what refs were fetched after you said "git fetch" (and no, looking
> at timestamp of files in .git/refs/remotes/origin/ is not a sensible
> answer).

We are talking past each other.

I understand the not-for-merge marker, why git fetch puts it there,
and how it is used by git pull.

I was asking why "git merge FETCH_HEAD" is useful, and you gave an
example of fetching a *single* branch using "git fetch <url>
<branch>". But in that case, as you said, git fetch does *not* leave a
"not-for-merge" marker, since only one branch was fetched.

So then, why does "git merge FETCH_HEAD" bother to strip out a
not-for-merge marker that wouldn't be there?

I can only guess there is a use case where one fetches multiple
branches and then uses "git merge FETCH_HEAD".

j.

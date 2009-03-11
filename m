From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/3] bash completion: fix completion issues with fetch, 
	pull, and push
Date: Wed, 11 Mar 2009 10:57:16 -0400
Message-ID: <76718490903110757j3b90dcffx4b81d2a02427008b@mail.gmail.com>
References: <cover.1236314073.git.jaysoffian@gmail.com>
	 <07bd381f7984117681504ce57c1f6c40aecafed3.1236314073.git.jaysoffian@gmail.com>
	 <20090306155814.GG16213@spearce.org>
	 <20090311190227.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 15:59:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhPtQ-0002I2-1O
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 15:58:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbZCKO5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 10:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbZCKO5S
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 10:57:18 -0400
Received: from rv-out-0506.google.com ([209.85.198.237]:56618 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbZCKO5R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 10:57:17 -0400
Received: by rv-out-0506.google.com with SMTP id g37so39592rvb.1
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 07:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0vCCS/YWI6iYHBXEBxXX1OLf1zy4bPsotVnq5MrKqAk=;
        b=XOXPyFqUlnpEDDK7GAIPJhkwg0dPQgW5wFpjzAegAv8Li7EY8h3/vYgQ/zfVFYhgKk
         OOzB9rq52I8eDWh0k4XMmf7EzmOotM7UDNMflMhGQAa2uScmeE1kFpz7EWLxA7CuPmxf
         j7XdWoeHA254dEkXxYYXPvSnxv4ZRTdOQZVyM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vuEI/KAQv4PRTVVCRkNtpxppfSUZq3VU1QLO4nxpAcxI6dMJmRDE2knez4P6/9xCn0
         iCCv/urRRj3kwfSmxirBHUJOaTgi5eqrwu8T/Ewe5Yo5tJ7qu5ldwz0brA1XTBHNH3dW
         vs1bR2GhgYbj0ffJpiA0J6uh/Q+r/naD0msoU=
Received: by 10.141.45.16 with SMTP id x16mr4408912rvj.290.1236783436174; Wed, 
	11 Mar 2009 07:57:16 -0700 (PDT)
In-Reply-To: <20090311190227.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112934>

On Wed, Mar 11, 2009 at 6:02 AM, Nanako Shiraishi <nanako3@lavabit.com> wrote:
> While people's attention is on the completion, there is one case I wish the completion worked better.
> "git log origin..mas[TAB]" and "git log origin...mas[TAB]" work as expected, but the same completion does not work for "git diff". I don't miss the two-dot format but it's often useful to say "git diff origin...master".

I just looked and realized to fix this properly, __git_complete_file
and __git_complete_revlist need some refactoring, along with the
functions that use them.

So I'll add it to my todo list, since it's more than 5 minutes of
available time I have right now.

j.

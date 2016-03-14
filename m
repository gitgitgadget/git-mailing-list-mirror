From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6] commit: add a commit.verbose config variable
Date: Mon, 14 Mar 2016 17:24:47 -0400
Message-ID: <CAPig+cRzDbBu=wFmkUGUm58aJoz-4oecPWfbCc=4oO6geyKj5Q@mail.gmail.com>
References: <0102015376e53b40-d25f7fdc-4ae1-4aae-b779-052fcf252071-000000@eu-west-1.amazonses.com>
	<CAPig+cRC5kZCtELhTh3em0bv+mfeR58AKd3Y76VM+0J+C+zzcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 22:24:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afZyv-0002Q5-0p
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 22:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbcCNVYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 17:24:50 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33851 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbcCNVYs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 17:24:48 -0400
Received: by mail-vk0-f67.google.com with SMTP id e6so15839923vkh.1
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 14:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=SPWMtZvbliI12z3KonnOKyD8p7Npqy8vKch7TIgRTWo=;
        b=x8U2I6lFhQ/0bSjBoqJx4VHJHhIZ2G9T3hhH358C/vkdimcxbyURx+wFmYYiLJROjA
         j7Tsidjykv8KrFv8KQEYTbScPIZCwBW4aR4+mIoMyvNZyuGF6vE3m0b7KLU4keaqJF+8
         ISxsNLSNCRG/E47cZTlCMDqp9y+cIeNaoMpAzUKlGZYvFCL+SXdkjKkfI3jaPFmeUPeP
         h2cU1n5ZMRAxh22BXe5ubSt7Yy5ietRYvZmApmE/UjaKjrj+4glQc96pCZWSdWU3ECea
         4Nkafs1eQIJXKNFU7wKlkwDp9zfu98m1HxK37Yh0e09YBMntt6sFNmM/lXr4cou1e3IG
         s2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=SPWMtZvbliI12z3KonnOKyD8p7Npqy8vKch7TIgRTWo=;
        b=WCt4tiMiXHPGRo0PpoR4D5LMDJ+m7T9whZcKr/h3bQdN1PQ2D5N0+jqMtwBhn7Fe8H
         sUMKrIDrUTeCqnzSLl/PTxg9DNI5E9bictWaktQpgu01EqdgRReUuR0FWgh/+huDNQFo
         /L3h7CE8YoUiE1YHHMi/p0Xy0vppfb7rjrb50Hb9X8J37dGOETIPxzywCyXEWkFSXpva
         Ea9Dhi+ry5+N/SiUsd0lizp1KSmxJblfPjD2C7kn9H+pEyWWom5g6vINBWbj+W8d+gBL
         vpng3yvpG/MD/C+4V9HmrZvNgkCuhISH/GxXP4E8M3zPzO+4rvXxF+mfZ+5TLdemjhoE
         SKhw==
X-Gm-Message-State: AD7BkJLBZ/SzsAG/sGseuKzFbgRiCiyTaUZhv10pkUMYgEN+DsIP1B5VN+HnDIiP1e9QY1DZYWCPlv9obZEr5Q==
X-Received: by 10.31.141.2 with SMTP id p2mr27765148vkd.37.1457990687803; Mon,
 14 Mar 2016 14:24:47 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Mon, 14 Mar 2016 14:24:47 -0700 (PDT)
In-Reply-To: <CAPig+cRC5kZCtELhTh3em0bv+mfeR58AKd3Y76VM+0J+C+zzcw@mail.gmail.com>
X-Google-Sender-Auth: ir4R-Da9wlQ2jGh-KKBwnyy815A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288815>

On Mon, Mar 14, 2016 at 5:21 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> +test_expect_success 'status ignores commit.verbose=true' '
>> +       git status >actual &&
>
> This is missing the important "-c commit.verbose=false". Without it,
> you're not really testing anything interesting.
>
> (It was missing in the "something like this" example test I typed
> directly in the email of my last review[1], which I suppose is a good
> lesson that "something like this" is not meant as "final" or "trust
> this".)

That wasn't an intentional omission on my part, by the way -- I wasn't
trying to mislead you -- it was just an example I typed on-the-fly
without thinking too hard about it.

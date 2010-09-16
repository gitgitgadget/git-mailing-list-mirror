From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/7] gitweb: allheads feature
Date: Thu, 16 Sep 2010 23:26:00 +0200
Message-ID: <201009162326.01656.jnareb@gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 23:26:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwLyC-0008AW-Ce
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 23:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704Ab0IPV0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Sep 2010 17:26:11 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:63675 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986Ab0IPV0K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 17:26:10 -0400
Received: by ewy23 with SMTP id 23so829335ewy.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 14:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=GXIQ5dXXQHq4h+N7IsW31wI0hfp/Ho5xTDFfUxCzxo0=;
        b=MSXbcJ7woL2RsqtBl3IwJNqQ60lGjldUqukX+y3Mg2rzyQU6cidR9AUZu3KqteH6LZ
         v6PbdEO5R4yE+Gsocj5D7sZE5/x3Eq31iSKj/SbCAOxOCS6C2KQcHrRSbWrziEp1nBId
         NCkxJJh6xWk20lWIGPgNOCWZzI/3Y+fIVk/+M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xr1MifJ5ovoyI/AkscrZUo6e9MD/Z2G+CwwzOqrhxj/ziGdZy5v42oAINMjwcSiRHT
         9GjWAj9m413k4zjWIk5W8EFmTaFhJzF4OqRMkqhQCzy5JP8++cZhS9G6rp19DNal2q8d
         sgvDFbnsC9ZAJNkBPaye1OQaJg4f8bQ3hie7c=
Received: by 10.213.2.207 with SMTP id 15mr3208884ebk.9.1284672368686;
        Thu, 16 Sep 2010 14:26:08 -0700 (PDT)
Received: from [192.168.1.13] (abvm37.neoplus.adsl.tpnet.pl [83.8.210.37])
        by mx.google.com with ESMTPS id u9sm4572659eeh.5.2010.09.16.14.26.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Sep 2010 14:26:07 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156355>

On Thu, 16 Sep 2010, Giuseppe Bilotta wrote:

> This is a rehash of an old patchset of mine that got stalled waiting for
> other independent patches to go in first, and then for me to get the
> time to work on it again.
> 
> The first 4 patches are IMO ready for inclusing in gitweb, and their
> purpose is to introduce a new view (and a new summary block) that
> display all the remote heads (assuming the feature is enabled).
> Somebody suggested via email that this could even the basis for some
> kind of 'social graph' for gitweb repositories, in a way similar to what
> is found on sites like github or gitorious, but for me the feature in
> itself can already be useful.

We might want to make git-instaweb enable this feature (and probably
other disabled-by-default features).  Otherwise some of information
about git repository you examine is hidden.  So I agree that this 
feature is useful by itself.
 
> The last three patches are more of the RFC side, in particular the last
> one. The idea is to group remote heads 'by remote' instead of just
> listing them serially. So I first introduce code and styling to have
> 'blocks of stuff' in gitweb, and then use this concept to group together
> remote heads belonging to the same remote.

This is a good idea in itself; I'd take a look at implementation and
styling when examining individual patches.

> The final result is rather curious and you can see it in action at
> <http://git.oblomov.eu/rbot/remotes>, although it would be nice to find
> a way to layout the blocks in a smarter way. 

Thanks for providing demo site.

Note that clicking on header for remote block, which should lead to
displaying of only single remote displays all remotes, see e.g.
http://git.oblomov.eu/rbot/remotes/a3li.  Moreover when I tried to
handcraft URL i.e. http://git.oblomov.eu/rbot/remote/a3li (with
'remote' rather than 'remotes' action) I get an empty list of heads.


About layout of 'remotes' view: to have remotes information aligned
we would have to either put everything in one single table (with remotes
headers being "colspan"), or style them with minimum width (which could
be good idea anyway).
 
> What I really don't like (at the moment) is the way things come out
> in summary view instead. 

What you don't like about it?  Should it be smarter and display only
list of remotes, perhaps even limited to 15 elements, if there are many
remote-tracking branches?  Or is it something else?

> The issue there is that we only gather 16 remote heads, so some remotes
> might have no branches displayed, but it becomes difficult to detect and
> indicate when remotes have incomplete information being displayed. A
> possible solution would be to call show-ref N times (N being the number
> of remotes) with a limit of 16/N heads, but that can be a lot of calls.
> So I'm open to suggestions on how to improve this part (maybe just show
> a flat view in the remotes section of summary view?)

Ah, I see...

Alternatively we could use smart limiting on the gitweb side.

-- 
Jakub Narebski
Poland

From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Can I have this, pretty please?
Date: Mon, 13 Aug 2007 10:17:20 +1200
Message-ID: <46a038f90708121517s3ce137e6x898e3f7a59d55a2f@mail.gmail.com>
References: <85ir7kq42k.fsf@lola.goethe.zz>
	 <alpine.LFD.0.999.0708121135050.30176@woody.linux-foundation.org>
	 <85abswo9gf.fsf@lola.goethe.zz>
	 <alpine.LFD.0.999.0708121219540.30176@woody.linux-foundation.org>
	 <85wsw0mt77.fsf@lola.goethe.zz>
	 <alpine.LFD.0.999.0708121255230.30176@woody.linux-foundation.org>
	 <69b0c0350708121358w13d04047s1916d3599c2e040a@mail.gmail.com>
	 <85y7gg5tc3.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Govind Salinas" <govindsalinas@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 13 00:17:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKLkT-0001ti-Ky
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 00:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764764AbXHLWRW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 18:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764671AbXHLWRW
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 18:17:22 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:18283 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762067AbXHLWRV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 18:17:21 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1045895wxd
        for <git@vger.kernel.org>; Sun, 12 Aug 2007 15:17:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aKqZISzLQEYu5rXbxJ9xjdHBL4a9VonFppxZlyLhJV8xSIMIVwuZ59DmABkMRmWygUyMECzdyqct5Iu2wyFUqublAGosapx96zHR/cr1boLzl++D57lQcdJrFCutCAODIyZYzh8/JTHBXCMw5CEZM59f8hcSjjTXxp3PVU9hi2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GaLY4guIpiOP/YYijDY6yiTwf+UGUv1NPOjCZ5NqFre4NnQRih095/nUFpUge1vGg9TBeZpJPPX8iRY0FsPTNk1NNa3MrMDgSBHlsEH5xexgDfgtzkmoSrBRUsWLRCuXxJ+frHDCNFlAhtYxG8ol6/9jnJ0wODhnGJ/cVeN/I9M=
Received: by 10.90.53.16 with SMTP id b16mr5835001aga.1186957040398;
        Sun, 12 Aug 2007 15:17:20 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Sun, 12 Aug 2007 15:17:20 -0700 (PDT)
In-Reply-To: <85y7gg5tc3.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55730>

On 8/13/07, David Kastrup <dak@gnu.org> wrote:
> Well, what I have in mind boils down to something I can use without
> leaving my editor... (...) and I naturally use Emacs.

heh! As an emacs user, I have to say this might just be a tad too much :-)

The main fix for your immediate woes of having gitk work fast is -
imho - to limit it by time, which I do all the time.

And on that track I'd *love* it if gitk could work as follows:
start-up as if I had said --since=10.days.ago (unless I pass an
explicit --since) and put a "get more history" button at the bottom of
the commit list. And make the default --since settable via git config
as gitk.since or somesuch.

That'd make newcomers to git go -- WOW -- on gitk, and save old hands
some typing ;-)

On the gnus backend - I don't think the nntp backend is good enough,
as it can't deal with merges. But if you can write up a new backend
that can read merges, you'll be golden. You'll definitely want to
limit the number of commits you read initially, too.

Now - both your emacs-gnus-git backend and gitk/qgit would benefit
from having a long-lived git process that you can talk to via a socket
for the stuff that you are bound to be asking a lot of (cat-file,
diff, etc). Something like git-fastimport but for common queries.

I *thought* there was one -- I was just reading gitk to check and not
look like a doofus -- but at least my gitk is exec'ing git cat-file
all over the place. I am sure that it'd speed up gitk and friends
enormoustly, specially on non-linux environments where IO isn't as
optimised.

cheers,



m

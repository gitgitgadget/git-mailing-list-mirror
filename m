From: "Andrew Arnott" <andrewarnott@gmail.com>
Subject: Re: Repo corrupted somehow?
Date: Tue, 4 Nov 2008 21:40:22 -0800
Message-ID: <216e54900811042140l33bd7cc4ndf7f2524b9d886f1@mail.gmail.com>
References: <216e54900811032309s51c8cb1fr64054ff18c450b1d@mail.gmail.com>
	 <alpine.LNX.1.00.0811042241450.19665@iabervon.org>
	 <216e54900811042127id69b61fqbd9d001b8bc17a6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Nov 05 06:41:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxb9C-0004Nk-8a
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 06:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbYKEFkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 00:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbYKEFkY
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 00:40:24 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:16303 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbYKEFkX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 00:40:23 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1338314yxm.1
        for <git@vger.kernel.org>; Tue, 04 Nov 2008 21:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tRugKSLv5H1fU+i2rK5H843GBBOtuMhBhr5irfX3vgU=;
        b=OWc9BVTzIutll2kFYOGUJ9mrzOW+jTa+Gu5CbbpL7hDoDr0kQ7MIjo7eHnTue77kHe
         h4Oge4fWSHyFeVfh0UCVrGU4Hid+ZLggpvPTazjwRk04vZO6ufwvvS1/QjTOy9HHFx43
         kObFIEE/Fh5P+Ru7m65Rjgz8/CDX+MP7VOYZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=l23gv0cMVuCZoOFbKy4dcybnXW5mzdLNTip1pS0uid2b8cunnZ6O0Vrj2SAdfOPRUw
         rrPdwDKY52fqgaQRFj1Y8VKFRzhEASUhz3/YwWaIgOHOHRDaf44ACmVTYgFbms21P+PB
         So7ibUNFV5l2itCOME/OaZw4fAEJJUkmyFxyU=
Received: by 10.151.144.15 with SMTP id w15mr1018526ybn.91.1225863622113;
        Tue, 04 Nov 2008 21:40:22 -0800 (PST)
Received: by 10.151.142.12 with HTTP; Tue, 4 Nov 2008 21:40:22 -0800 (PST)
In-Reply-To: <216e54900811042127id69b61fqbd9d001b8bc17a6a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100144>

It was the CRLF conversion.  When I played around with
git config --global core.autocrlf true/false
I got the problem to eventually go away.

Thanks for all your responses.

>
> On Tue, Nov 4, 2008 at 8:21 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
>>
>> On Mon, 3 Nov 2008, Andrew Arnott wrote:
>>
>> > I was just git commit'ing, and then I was doing a git rebase to squash
>> > several commits into one when the rebase failed.  I then did a
>> > git checkout -f master
>> > git reset --hard
>> > but no matter what I do, git thinks that several files have changed.
>> > The diff shows all the lines in these several files removed and then
>> > added, yet without any changes made to them.
>>
>> That sounds like some failure of CRLF conversion, like it's converting all
>> of the line endings somehow when writing to the working tree and then not
>> expecting them to be different. Do you have some sort of interesting
>> configuration for those? I wonder if you've got a .gitattributes that
>> matches the names that git uses for the files, but are on a
>> case-insensitive filesystem which lists those files in a way where their
>> names don't match (or vice versa).
>>
>>        -Daniel
>> *This .sig left intentionally blank*
>

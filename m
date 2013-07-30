From: Bryan Turner <bturner@atlassian.com>
Subject: Re: Flatten history
Date: Tue, 30 Jul 2013 13:59:00 +1000
Message-ID: <CAGyf7-FXp-a+HmoRQBrUWu2xc-UvbsZUfZz7GTce2JzwrsfMVw@mail.gmail.com>
References: <CAE1pOi0CQ1k3h3ie=s3qvkQog9foYBOnJ++uuum-Br7vzQHRSQ@mail.gmail.com>
	<CAMP44s2pXSN2HbpGLW9jrgJAypbLM3JtgD+nyK7LkNdvH4nsfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 05:59:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V415a-0001zF-9Q
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 05:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757254Ab3G3D7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 23:59:03 -0400
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:53616 "HELO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755010Ab3G3D7B (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jul 2013 23:59:01 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]) (using TLSv1) by na3sys009aob132.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUfc6BPPY6qDIpz9R2MyOzxEFhqV8+GxU@postini.com; Mon, 29 Jul 2013 20:59:01 PDT
Received: by mail-oa0-f47.google.com with SMTP id m6so8041764oag.20
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 20:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-gm-message-state;
        bh=9Ynw/zGrirk+hSHgXILEE9KKATJLFBLeJHRdb6gh6CQ=;
        b=KmJ1ea321bPxfOnlnWqt/1oXjd8zv5wCQWH1rqt22IKRvPW8Q03td3KvYRgHoE5nui
         d6CVAF3v5je4vKNxdhE94skakibpJCouEYQfNbuvd4V5OJYm1CRRSEHUoIy080aUkM0R
         xEPcPAMe6UFDoz9biG3wmU9kBsq6QsmGUw8rMAGzpx9FaF+K+1jXBQ3/5aUMBEmA+asj
         tfPWc6u2pVn4b4y50h/+tEA4iO7CcgHaJqUFS/Rq6astL5ccN+rSsqEol+a6p8p0DvtO
         Lwfl8uXYO8fhz4xJnWveBKjfQXkkFRtXCXe6WIKXNA4jr9q/pUC+H7hEYA+rRdc/abVd
         TdlQ==
X-Received: by 10.182.142.104 with SMTP id rv8mr55017586obb.3.1375156740356;
        Mon, 29 Jul 2013 20:59:00 -0700 (PDT)
X-Received: by 10.182.142.104 with SMTP id rv8mr55017582obb.3.1375156740280;
 Mon, 29 Jul 2013 20:59:00 -0700 (PDT)
Received: by 10.182.158.194 with HTTP; Mon, 29 Jul 2013 20:59:00 -0700 (PDT)
In-Reply-To: <CAMP44s2pXSN2HbpGLW9jrgJAypbLM3JtgD+nyK7LkNdvH4nsfQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQn7r9sNobmb0NCOMJXGplTRkv4Z6M8UFRxcWV4j1jI1s9UAWmoc4WEAACiCmRukIRk+CV28g0jmXIrN27OUOtk3cOBU/GVWAlo0ZFCIoxU34whZKAvdaGhnsafeLDvHlSlogEPF8u5dyVBPI5/n1CKgDWuLXA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231346>

On 30 July 2013 13:50, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> On Mon, Jul 29, 2013 at 8:42 PM, Hilco Wijbenga
> <hilco.wijbenga@gmail.com> wrote:
>> Hi all,
>>
>> I have a (public) "feature" branch that has been kept up-to-date with
>> "master" by regularly merging master back into it. I would now like to
>> get all the changes from feature but not any of the commits.
>> Basically, I want to replay all of feature's commits without creating
>> those commits.
>>
>> I thought something like
>>
>> git cherry-pick -n abcd^..feature
>>
>> should do the trick (while on master, where abcd is the SHA-1 of the
>> commit where feature was created) but I get conflicts.
>>
>> First, why the conflicts? I have done all the merges so cherry-pick
>> should simply be able to replay them? Second, what is the correct way
>> of doing this?
>
> Perhaps
>
> % git cherry-pick -n --no-merges --right-only --topo-order
> --cherry-pick abcd^..feature
>
> --
> Felipe Contreras

Wouldn't git merge --squash do what you're looking for? It seems like
the only way to not get conflicts trying to cherry pick is if you
never had any conflicts while you were merging master into your
feature branch. "Evil" merges, where you actually have to change code,
even if it's just to resolve conflicts, don't tend to replay
correctly.

It seems like this should do it:
% git checkout master
Switched to branch 'master'
% git merge --squash feature
Squash commit -- not updating HEAD
Automatic merge went well; stopped before committing as requested
% git commit

git merge --squash will just apply the changes without creating a
commit. You can then make any final changes you want to and write your
commit message for the feature.

Hope this helps,
Bryan Turner

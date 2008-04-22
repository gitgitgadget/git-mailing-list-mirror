From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 22 Apr 2008 21:59:46 +0800
Message-ID: <46dff0320804220659j66dea3fehc2a9bdcdc0371025@mail.gmail.com>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
	 <7vwso5r87q.fsf@gitster.siamese.dyndns.org>
	 <7v8x0992hy.fsf@gitster.siamese.dyndns.org>
	 <7vd4pf7h9y.fsf@gitster.siamese.dyndns.org>
	 <7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
	 <7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
	 <7vbq4j748l.fsf@gitster.siamese.dyndns.org>
	 <7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
	 <7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
	 <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 16:00:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoJ3F-0001yV-Df
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 16:00:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933786AbYDVN7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 09:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933670AbYDVN7t
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 09:59:49 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:3812 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763371AbYDVN7r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 09:59:47 -0400
Received: by an-out-0708.google.com with SMTP id d31so599982and.103
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 06:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6JNy0IJghhHtyEKO0gFpGjSevyc3pb17TcCGFzeeyE8=;
        b=KvNK5VuqQsBTbF4sH6ahf1bGOHfHZadjxHzn5lRUL+xXVqkp73+EK9fM/8DsSk1T9ci1qyzWHaykLWA3tf/ll99jOukC2tDPo3bra59AykA5VnNeouo2AEEIz9bDeHRB0pjwDWKcOEumt+7hCZSHDdyFH/ig03GcSdil76FHNpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DtaBChui42Ym9NFqJ3xxLkxYQntZBz12H/PwGzFv4DwpJMhXtb7nqyBUixvhzuS1B1eRcDNgHxVTGSlvoJcG1pKFMCFF6j9ees5WcD45DRhpSKc9eOAFFB7rL0rrJsv+mwzgd+9dgTaddSWx/Ee59Rr0ylmlMUBGTYkoe3zmQmA=
Received: by 10.100.190.14 with SMTP id n14mr399143anf.98.1208872786764;
        Tue, 22 Apr 2008 06:59:46 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Tue, 22 Apr 2008 06:59:46 -0700 (PDT)
In-Reply-To: <7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80121>

On Tue, Apr 22, 2008 at 6:03 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Here are the topics that have been cooking.  Commits prefixed
>  with '-' are only in 'pu' while commits prefixed with '+' are
>  in 'next'.
>

>
> * py/submodule-2 (Wed Apr 16 22:19:31 2008 +0800) 1 commit
>   - git-submodule: Extract functions module_info and module_url
>
>
> I only managed to queue the first one so far.
>
>  It does not help motivating me reviewing the series that the overall tone
>  of it is to ignore .git/config more and make .gitmodules take more active
>  role, either.  I have already said number of times why that is not a good
>  idea and why it is against the overall submodule design.

I summarize junio's points that says $GIT_DIR/config is authoritative.

1. .gitmodules shouldn't be authoritative and should be just a hint
   to fill $GIT_DIR/config because

   a) url may be rewritten with different protocol, such as from
     "http://" to "git://"
   b) url may be total different between .gitmodules and
      $GIT_DIR/config

2. When going back to an old HEAD of super project and do
   "git submodule update", the url recorded in .gitmodules may be
   stale or not existent anymore, so we should refer to
   $GIT_DIR/config for the right url.

3. We can record what contents we've seen in the .gitmodules, so that
   we can give users a chance to adjust what is in $GIT_DIR/config
   when we notice the entry in .gitmodules has changed.

Any others?

However, i argue the fall back strategy (say fall back to .gitmodules
when we can't find an entries in $GIT_DIR/config) doesn't break the
authority and isn't in contrast with the cases above. It just attachs
more importance to .gitmodules and can make the world better in most
cases.

For 1.a, i think we can keep these entries in .gitmodules, and use
"url.<thisurl>.insteadof = <otherurl>" to override the urls.

For 1.b, i think this is a rare case. And we can override these urls
in $GIT_DIR/config. However, in many cases, we havn't to do that.

For 2, i think it is also a rare case. And before going back, we can
override the urls in $GIT_DIR/config.

For 3, i havn't found a good way to do that. And it doesn't conflict
with the fall back strategy (say, wh

So, my conclusion

* 1.b, 2 and 3 are all rare cases, and these cases don't conflict with
  the fall back strategy

* 1.a is a usual case, and fallback + 'url insteadOf" will make things
  better

* The most common case is that most (even all) entries in .gitmodules
  are the same as entires in $GIT_DIR/config. So with fallback, we
  don't have to copy entries from .gitmodules to $GIT_DIR/config.

* And, in a central environment, i think it's common that the super
  project and sub project use the same protocol. So if we use relative
  urls in .gitmodules, when changing the url protocol the super
  project, the urls in .gitmodules needn't change and can be
  dynamically expanded with the url of the super project (Of course,
  after applying the 2nd patch of this series)


-- 
Ping Yin

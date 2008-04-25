From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/5] New merge tests
Date: Fri, 25 Apr 2008 02:37:35 -0700 (PDT)
Message-ID: <m3tzhqp96h.fsf@localhost.localdomain>
References: <402c10cd0804232243u700f4f6fv130d69283c40ff1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 11:38:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpKNv-0002RY-Ra
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 11:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759715AbYDYJhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 05:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759638AbYDYJhj
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 05:37:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:12979 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759386AbYDYJhh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 05:37:37 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1410275nfb.21
        for <git@vger.kernel.org>; Fri, 25 Apr 2008 02:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=AytXem2xRU+JWWrA3htjbI4c5tvS3/FgJypzRq9hvW4=;
        b=w6dImvjAQwclX66hjuiQx91rgObFc9POOpf+SThxEeD6GqcCCuXu2avPR6xFMQWRHC+IkKrNtjzT9SF5nlADSxxaW+bfS7WaQvTRzYzNt0VrNa0Qm5JyuDIUJUuuuNUASq2yzzTzLkweqq7Z4iUNxNBtnpaFrvpyekxJazDeGvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=JYFa+YYAic8maYbf5l988P8Pz1ZMWksEXQHZQ0bXq5J0ZOYvVmMs6gcwNCHbBppoB5fjR6FtOXClkoki8OlBLSFB+ptZxcNaaKP63U+fg5l2apSO/8uT62oZm3T2+s/vOXQycQCwDTCHeLrlUCr/40jkqZiw99v+q5pIKZTM99M=
Received: by 10.210.21.13 with SMTP id 13mr2112157ebu.75.1209116256712;
        Fri, 25 Apr 2008 02:37:36 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.255.239])
        by mx.google.com with ESMTPS id i8sm2451300nfh.1.2008.04.25.02.37.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Apr 2008 02:37:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3P9bT8W022802;
	Fri, 25 Apr 2008 11:37:30 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3P9bAMl022794;
	Fri, 25 Apr 2008 11:37:10 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <402c10cd0804232243u700f4f6fv130d69283c40ff1d@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80330>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> Introduce new merge tests for preparation of new features:
> 
>   --ff=<fast forward option>
>   Head reduction
>   --ff=only

I think you should describe here _what_ is tested by the new test(s),
and how it is named.

BTW. the test itself is a bit short on comments...
 
> +create_merge_msgs() {
[...]
> +verify_diff() {
[...]
> +verify_merge() {
[...]
> +verify_head() {
[...]
> +verify_parents() {

It would be nice to have 1 or 2 lines description of those functions,
perhaps with calling convention.  See for example comments in
t/test-lib.sh (some of which are in t/README instead ;-).

> +verify_merge() {
> +       verify_diff "$2" "$1" "[OOPS] bad merge result" &&
> +       if test $(git ls-files -u | wc -l) -gt 0

What are conventions used by other tests?  Somehow I doublt is is
"[OOPS]"...

Instead of
       if test $(git ls-files -u | wc -l) -gt 0
you should write IMHO
       if test -n "$(git ls-files -u)"
or just
       if test "$(git ls-files -u)"

[...]
> +test_expect_success 'setup' '
> +       git add file &&
> +       test_tick &&
> +       git commit -m "commit 0" &&
> +       git tag c0 &&
> +       c0=$(git rev-parse HEAD) &&
[...]
> +'

It would be nice if you have provides, as comment to this step,
ASCII-art graph of commits you want to have created.

BTW. instead of
       c0=$(git rev-parse HEAD) &&
you can use
       c0=$(git rev-parse c0^{}) &&

or even "c0^{commit}".

[...]
> +test_expect_success 'merge c1 with c0 and c0' '
> +       git reset --hard c1 &&
> +       git config branch.master.mergeoptions "" &&

Not "git config --unset branch.master.mergeoptions"?

-- 
Jakub Narebski
Poland
ShadeHawk on #git

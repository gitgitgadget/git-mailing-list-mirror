From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] remote-hg: add shared repo upgrade
Date: Tue, 6 Aug 2013 08:53:14 +0200
Message-ID: <CALWbr2y+fE1EvGuTQXQiL81yavpDR+RqmrxWjNTUme-fmjY8EQ@mail.gmail.com>
References: <1375730567-3240-1-git-send-email-apelisse@gmail.com>
	<7vwqnzj1gp.fsf@alter.siamese.dyndns.org>
	<CALWbr2wynb-K-r0sehuBUtmkbgp9Ev5iYK_v2ZFxsjcewTCmfQ@mail.gmail.com>
	<7vfvuniavq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Joern Hees <dev@joernhees.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 08:53:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6b9F-0007jJ-0S
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 08:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211Ab3HFGxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 02:53:15 -0400
Received: from mail-qe0-f41.google.com ([209.85.128.41]:47590 "EHLO
	mail-qe0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab3HFGxP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 02:53:15 -0400
Received: by mail-qe0-f41.google.com with SMTP id a11so5357qen.0
        for <git@vger.kernel.org>; Mon, 05 Aug 2013 23:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HHy8uJBIC9MJ1Pn51YkFxeDD3/bZRe7QEwa31rnKG2c=;
        b=R7DYDMpmdiyRvcjE8e13BJmvpr9eDaYKCzXtv/42QenH3fbS09rj04bz6CILbd1Xf9
         nyPB+E3psWuG9ExsfnfAMMNS65lCdJ3etjcomW+Zior6Mx4mxyyfXW10jWGKKlGmzPHE
         ptPm4cFWNzFVLkRijuGhPAI1MQ9RrZahZIYyEIgj047PeJ14lhfwR1DqhpfI/tqU3umz
         zaejXI9rCOrgJTBrc4SbwbHekQKe3MUnYo7aa8RtfouwMvhDBmtVHVSUz/ncLyR/by3E
         DwTAM7gXZUVZHqQrfHvsr9EdEpqcpoyqcrPTNVkQOJxeeQnqKkXRBzFf5Ch6107bK9YZ
         nCkQ==
X-Received: by 10.224.64.132 with SMTP id e4mr1499271qai.46.1375771994372;
 Mon, 05 Aug 2013 23:53:14 -0700 (PDT)
Received: by 10.49.64.67 with HTTP; Mon, 5 Aug 2013 23:53:14 -0700 (PDT)
In-Reply-To: <7vfvuniavq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231729>

On Tue, Aug 6, 2013 at 8:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
> Quoting that part I was asking about again:
>
>> +        # check and upgrade old organization
>> +        hg_path = os.path.join(shared_path, '.hg')
>> +        if os.path.exists(shared_path) and not os.path.exists(hg_path):
>> +            repos = os.listdir(shared_path)
>> +            for x in repos:
>> +                local_hg = os.path.join(shared_path, x, 'clone', '.hg')
>> +                if not os.path.exists(local_hg):
>> +                    continue
>> +                shutil.copytree(local_hg, hg_path)
>
> if you can have more than one 'x' such that

OK, Sorry for the misunderstanding, I read "at least one", instead of
"at most one".
Yes, I think "break" is missing right after copytree().

From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/5] git-log.txt: rewrite note on why "--" may be required
Date: Sun, 21 Apr 2013 14:35:46 +0530
Message-ID: <CALkWK0nHbm4La4kJ6cNzEnMas5B7Q2M=z_9d+O6iNX2r2bi98A@mail.gmail.com>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
 <1366458313-7186-5-git-send-email-artagnon@gmail.com> <7vtxn0wf4j.fsf@alter.siamese.dyndns.org>
 <CALkWK0nFAzPPb0_jTRev6nuicCV81sRQAbe=277nhyyY8TnQ7A@mail.gmail.com>
 <7v8v4cwd6g.fsf@alter.siamese.dyndns.org> <CALkWK0kiT7vggXgqGs2iiMooiw7TyJEgr2=Yy06S7H1NKiWJ3g@mail.gmail.com>
 <7vzjwsuxzp.fsf@alter.siamese.dyndns.org> <CALkWK0kEngwYQieR=Xmvzu+XqBe+ZFxiWj0C8M-euFavDDaD2Q@mail.gmail.com>
 <20130421080907.GF10429@elie.Belkin> <7vvc7guvu4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 11:06:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTqEC-0008MQ-1l
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 11:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735Ab3DUJG1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 05:06:27 -0400
Received: from mail-ia0-f170.google.com ([209.85.210.170]:33257 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752599Ab3DUJG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 05:06:27 -0400
Received: by mail-ia0-f170.google.com with SMTP id 21so4453140iay.29
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 02:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=3ic9axD77ckP3/wETJUjFm9Dl6lGC+YckTILt1tVcWU=;
        b=PtQTZkc3RpzBDQjPsR3Nn0WmOYfvKJIE4apkt67jzN7Y47csmHQ+UUZnRQeTCCTqnP
         +nrXrdVL9BN7AtHzZznzlW46LGpITHAysHV7KY5zLDth/Ci974j1GMx1nZO9d9QgkQWT
         mpWpwRHPFM0ouwlgnMMKzn44sJBPzVegPH7d2dfJzkGrSpmS5nmqTt0iLpl6HWjcV6il
         AsdK5tFoxyEW0MzgAegdXXzG+AeDm1F51lJTw+snm1OucBdeOTlMW7GIM6tICnTdWhDk
         sgZewxtHPKT/9t3X3S+jHiPmMzEzm4D0IBZ7TLeMk5NgolIECi5cuxKE0t/h/30D9Q4i
         A2Ug==
X-Received: by 10.43.9.68 with SMTP id ov4mr11100442icb.22.1366535186705; Sun,
 21 Apr 2013 02:06:26 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 21 Apr 2013 02:05:46 -0700 (PDT)
In-Reply-To: <7vvc7guvu4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221936>

Junio C Hamano wrote:
>  - A revision range is a slice of history.  There is no need for
>    "committish revision range" as there is no other kinds of ranges.

For the record, 'git rev-parse master:README..HEAD@{3}~2' works just
fine.  I don't know whether you want to consider it "sensible" or not,
but the current revisions.txt is consistent with this.

>  - A revision should be a synonym to a committish, as glossary
>    defines.  We historically used "revision" more or less
>    interchangeably with "object name", especially "an extended SHA-1
>    expression that is used as an object name", to mean whatever
>    get_sha1() can grok down to a single object name.  This must be
>    rectified to avoid causing confusion to new readers of our
>    documentation.

The question is: who is the authority on this?  The combination of
rev-parse, rev-list, and revisions.txt, or gitglossary.txt.

>    They are: "specifying revisions", "specifying object names", and
>    "specifying ranges".

Personally, I don't like giving commit objects a special status, and
like things just the way they currently are.  Why do you want to
separate "revisions" (which are really just "extended SHA-1
expressions" that incidentally resolve to commit objects) and
"extended SHA-1 expressions that resolve to objects other than
commits"?  Is the current hand-wavy unclear gitglossary.txt the only
basis for your argument?

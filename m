Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3CDB1FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 19:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbdBFTcn (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 14:32:43 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33464 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbdBFTcm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 14:32:42 -0500
Received: by mail-pg0-f66.google.com with SMTP id 194so9854496pgd.0
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 11:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LNIucPzg5UwIpAIyxTifHvYxJc/QPcAtkmlh2vUYGD4=;
        b=Ky1UTbxU6XkR10gGbOP4GBy0FZTHdQ4gd/r7yXP7qo5rv9mzq7urBHWhnBbn+UN1Ni
         l7VtKVIkn7FWnG1xyh1tZexI8U4sjwCY52vAAaOg72AxH2GOB+AEpV9Opbyeh+yIdGFb
         uiyzy64SdcvTHJwBGizJ2h6X70vN+2zEOLx0tZ/onVOU6tbbWHfQZmv8wWWVDbfjPdnq
         5V8NhBIDin3ABFRit8qCHFVKpSsVSLYRDKk7VcziwdVyXXD3GWjukCfIGi/omnerNiIS
         qId/HCkSHGJsIcQqw2QQj48N9p4Ot1wwY1nXrnpj+ZI0BsXigBKMhr0ydJgS6rGCTs05
         cN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LNIucPzg5UwIpAIyxTifHvYxJc/QPcAtkmlh2vUYGD4=;
        b=Sl8R9c+EK52f0iYiovHuKQO7xJzrDVOys/SjQymdS2y4LELp67CENOkmHYZc1xh7yp
         P2T7Klpj44p9G2DYCRQ3/XYAKYac0ZpmGvJAAcz9YlYqPuLNZr27EicaPQyGNdxUpLIt
         7tg5pNJwlJEjvVqKTZTn0CgKyVqBOV1WxVGloZBXx8yg7pqDrhGS/Q/2m+BxZvxNpWwe
         mxsuOee6QGbnekkPb4h1D2YS6hwQZWnORETUuaSTUoUoJ0Pu2VTfo6zvk5j9css1QVqB
         gaQuhljCuI9Xuo6ToXwjnXv4lHhx2GWOAyDMHiUH3BnaINI2Veo2/XWWqZTRnv5HcvVY
         K70A==
X-Gm-Message-State: AIkVDXIzg5Zlk+TSvOdqqQ9non0wjUdthtf+x98zl61M0Zvfd2ezvEifWrE0CNrF0bGQ6g==
X-Received: by 10.98.57.154 with SMTP id u26mr15017965pfj.136.1486409561872;
        Mon, 06 Feb 2017 11:32:41 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:310c:cda4:fdbc:2aa2])
        by smtp.gmail.com with ESMTPSA id t185sm4612673pgb.32.2017.02.06.11.32.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Feb 2017 11:32:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     cornelius.weig@tngtech.com
Cc:     git@vger.kernel.org, karthik.188@gmail.com, peff@peff.net
Subject: Re: [PATCH v3] tag: generate useful reflog message
References: <xmqqo9yg43uo.fsf@gitster.mtv.corp.google.com>
        <20170206135834.19637-1-cornelius.weig@tngtech.com>
Date:   Mon, 06 Feb 2017 11:32:39 -0800
In-Reply-To: <20170206135834.19637-1-cornelius.weig@tngtech.com> (cornelius
        weig's message of "Mon, 6 Feb 2017 14:58:34 +0100")
Message-ID: <xmqqpoiv15ew.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cornelius.weig@tngtech.com writes:

> +	strbuf_addstr(sb, " (");
> +	type = sha1_object_info(sha1, NULL);
> +	switch (type) {
> +	default:
> +		strbuf_addstr(sb, _("internal object"));
> +		break;

The code does not even know if this is an "internal" object, does
it?  What it got was simply an object of an unknown type that it is
not prepared to handle.  It's not like you are trying to die() in
this function (I see a die() upon failing to read the referent
commit), so I wonder if this should be a die("BUG").

On the other hand, it's not like failing to describe the tagged
commit in the reflog is such a grave error.  If we can get away with
being vague on a tag that points at an object of unknown type like
the above code does, we could loosen the "oops, we thought we got a
commit, but it turns out that we cannot read it" case below from
die() to just stuffing generic _("commit object") in the reflog.

Between the two extremes above, I am leaning towards making it more
lenient myself, but others may have different opinions.

> +	case OBJ_COMMIT:
> +		c = lookup_commit_reference(sha1);
> +		buf = read_sha1_file(sha1, &type, &size);
> +		if (!c || !buf) {
> +			die(_("commit object %s could not be read"),
> +				sha1_to_hex(sha1));
> +		}
> +		subject_len = find_commit_subject(buf, &subject_start);
> +		strbuf_insert(sb, sb->len, subject_start, subject_len);
> +		strbuf_addf(sb, ", %s", show_date(c->date, 0, DATE_MODE(SHORT)));
> +		free(buf);
> +		break;
> +	case OBJ_TREE:
> +		strbuf_addstr(sb, _("tree object"));
> +		break;
> ...

> +git log -1 > expected \
> +	--format="format:tag: tagging %h (%s, %cd)%n" --date=format:%F
>  test_expect_success 'creating a tag with --create-reflog should create reflog' '
>  	test_when_finished "git tag -d tag_with_reflog" &&
>  	git tag --create-reflog tag_with_reflog &&
> -	git reflog exists refs/tags/tag_with_reflog
> +	git reflog exists refs/tags/tag_with_reflog &&
> +	sed -e "s/^.*\t//" .git/logs/refs/tags/tag_with_reflog > actual &&

I'd spell that "\t" with an actual HT to make it portable [*1*].  

We have one example that uses the form in git-filter-branch
documentation and a script in the contrib/ area, but otherwise do
not have anything that relies on \t to be turned into HT by sed.

> +	test_cmp expected actual
> +'
> +
> +git log -1 > expected \
> +	--format="format:tag: tagging %h (%s, %cd)%n" --date=format:%F
> +test_expect_success 'annotated tag with --create-reflog has correct message' '
> +	test_when_finished "git tag -d tag_with_reflog" &&
> +	git tag -m "annotated tag" --create-reflog tag_with_reflog &&
> +	git reflog exists refs/tags/tag_with_reflog &&
> +	sed -e "s/^.*\t//" .git/logs/refs/tags/tag_with_reflog > actual &&

Likewise.


[Reference]

*1* http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_03

    9.3.2 BRE Ordinary Characters

    An ordinary character is a BRE that matches itself: any character in
    the supported character set, except for the BRE special characters
    listed in BRE Special Characters.

    The interpretation of an ordinary character preceded by an unescaped
    <backslash> ( '\\' ) is undefined, except for:

    - The characters ')', '(', '{', and '}'

    - The digits 1 to 9 inclusive (see BREs Matching Multiple Characters)

    - A character inside a bracket expression

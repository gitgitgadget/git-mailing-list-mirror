Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C52B1F461
	for <e@80x24.org>; Thu, 20 Jun 2019 17:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfFTR0y (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 13:26:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38960 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfFTR0y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 13:26:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so2045451pfe.6
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 10:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NW7bLc85DuRybPeHQwZdX5+x3Oq4NPRBGooLDj8MmCw=;
        b=EJ+6bSQ/h+FgHmmsTSGhplCCgzVhq481x7+Aysq7HeRz6B7simAnxfebLYsY2qFny4
         cWRe8panoB1x17R+sncEx0PG0ODOCSxqBe8gBXT1iYaGv/hQU3dAJwOb4UQlF9YZhPeb
         yPXlLGr7iMAFyAsX+BN4AH+nCm2KPXXIG0NKMJatkSrIz2fnANfOU3SFL7rEI6nr8mTE
         LKI4knZAuVVRAZyrmP5oMWbNyCEIEqBKPdUTMYNIzCS1TGkKIF2FS2R0OR/1fYZMeW6f
         dqzw9RPNyPpyv49+tTd6ZpWlvvpIZBaUVOVL7C8g3CKmNhanZhlRA3W8x21Z4M7a+0A7
         8F7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=NW7bLc85DuRybPeHQwZdX5+x3Oq4NPRBGooLDj8MmCw=;
        b=Z6CoyaL3n39jYuGCsEDplYJ0neOq1aQfQZusFgYLcmaRMSdGYR1uCOlncbExO+Og1j
         N1c8i6p3rQx70qlQi1Az6dJq9bzbbdlqdrYZAeN/YxtdvbzTNELCzz2mAq+uphWRViDK
         rFeFwuCqR8/Cg3GkMRbdKoXqtnwwvRNm726E9LWE7b/UqbzE67Ok02g6XUmeT/u8POXJ
         BslZf+vOTPFWHLcSwX+wqseDWlyhyMXf0Bn9LJozIlCv22MYw/nhvW60+2QL0hGB2ygi
         EclnznJjoyPkfSOQqMtRgl6Xe+eYJHtA9aLU6qADwnMPDQHIZUcGnd9HXuQWTrC5LXD8
         lsvA==
X-Gm-Message-State: APjAAAVfGMTrYVpwEFKEpwe5bDI6AxF5IAx1uRzxMu+4EDFH5Z7PdJpK
        MB4KUVNNoXbQOumBzDmQ5pDfIEEqloaMLw==
X-Google-Smtp-Source: APXvYqwBrKrti2EG9acmglGh9U06jbGasR4VyklST77DquOyOhNM9ZIwN4xuDVrQIfTn73xwLJRAZw==
X-Received: by 2002:a17:90a:2567:: with SMTP id j94mr743463pje.121.1561051612855;
        Thu, 20 Jun 2019 10:26:52 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id t8sm89942pfq.31.2019.06.20.10.26.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 10:26:51 -0700 (PDT)
Date:   Thu, 20 Jun 2019 10:26:46 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] trace2: Add a JSON schema for trace2 events
Message-ID: <20190620172646.GD42943@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org
References: <cover.1560295286.git.steadmon@google.com>
 <8dd0277222efa265f1e911c8476305feb3c2c3fb.1560295286.git.steadmon@google.com>
 <c624600c-42d6-d68f-28c1-916efc6b38b6@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c624600c-42d6-d68f-28c1-916efc6b38b6@jeffhostetler.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.06.14 11:59, Jeff Hostetler wrote:
> 
> 
> On 6/11/2019 7:31 PM, Josh Steadmon wrote:
> > Define a JSON schema[1] that can be used to validate trace2 event
> > objects. This can be used to add regression tests to verify that the
> > event output format does not change unexpectedly.
> > 
> > Two versions of the schema are provided:
> > * event_schema.json is more permissive. It verifies that all expected
> >    fields are present in each trace event, but it allows traces to have
> >    unexpected additional fields. This allows the schema to be specified
> >    more concisely by factoring out the common fields into a reusable
> >    sub-schema.
> > * strict_schema.json is more restrictive. It verifies that all expected
> >    fields are present and no unexpected fields are present in each trace
> >    event. Due to this additional restriction, the common fields cannot be
> >    factored out into a re-usable subschema (at least as-of draft-07) [2],
> >    and must be repeated for each event definition.
> > 
> [...]
> > +
> > +		"data-json_event": {
> > +			"allOf": [
> > +				{ "$ref": "#/definitions/event_common_fields" },
> > +				{
> > +					"properties": {
> > +						"event": { "const": "data-json" },
> > +						"repo": { "type": "integer" },
> > +						"t_abs": { "type": "number" },
> > +						"t_rel": { "type": "number" },
> > +						"nesting": { "type": "integer" },
> > +						"category": { "type": "string" },
> > +						"key": { "type": "string" },
> > +						"value": true
> > +					},
> > +					"required": [
> > +						"event", "t_abs", "t_rel", "nesting", "category", "key",
> > +						"value"
> > +					]
> > +				}
> > +			]
> > +		}
> > +	},
> [...]
> 
> Here you have "value" as just a boolean rather than a sub-object.
> Is that a limitation of the schema tools?  I guess this is reasonable
> since the contents of the sub-object are variable and you wouldn't be
> able to verify it anyway.

Yeah, I just listed it as "true" (which in JSON-Schema means that a value is
expected but we're not making any restrictions on what it looks like) because of
not being able to verify the contents of the sub-object. But we should actually
at least verify that it's an object versus some other type, so I'll fix that if
there's enough interest for a v2 of this series.

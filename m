From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC 02/11] remote.c: add infrastructure for parsing --prune options
Date: Wed, 4 Dec 2013 19:57:22 +0700
Message-ID: <CACsJy8DwfXPn6vJXuMyNP7W3tKe2w_mzxdw53kL=-T+0YU5wCw@mail.gmail.com>
References: <1386135890-13954-1-git-send-email-mhagger@alum.mit.edu> <1386135890-13954-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Dec 04 13:58:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoC1f-0002kS-0r
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 13:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386Ab3LDM5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 07:57:55 -0500
Received: from mail-qc0-f176.google.com ([209.85.216.176]:35128 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932201Ab3LDM5x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 07:57:53 -0500
Received: by mail-qc0-f176.google.com with SMTP id i8so3317789qcq.21
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 04:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ubFIJ7MiIAB66tVFXuW/X1+9Q45+EU5pUq0khB246TI=;
        b=qJLCuSPbiGuo9kGDXDeJjMTr9ufiIefx1/j01m8nZ4I0ZmV1z1fpBO/DnRTil0/3Gr
         +ZgUpMdvWSEmK4UTv9Bo0OqgVUsXggghLnNXNriP0Zgx/+RKIfcohMI+VCtacayP014s
         8CwxDspa6M9am1cya0gMf8Oqge0XEIB9xfOPTXik7nb0NHvupV66dr3M8mt2ReEJmO6G
         1ecU8ggtDXutftGuW3ZkkBDD43GNYDr+nbHW2/G+tDjvKi9TnI/nCqr6Xp+C3HRKEomm
         tdq99SV/eQ23J3L8+PkecPQwtWG4Tu4+l/4IJP/wFk6iMbqfoVW3sY1dXvCaJX5OA1wN
         7I8g==
X-Received: by 10.49.1.106 with SMTP id 10mr136524278qel.55.1386161873055;
 Wed, 04 Dec 2013 04:57:53 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Wed, 4 Dec 2013 04:57:22 -0800 (PST)
In-Reply-To: <1386135890-13954-3-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238774>

On Wed, Dec 4, 2013 at 12:44 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> +void argv_push_prune_option(struct argv_array *argv,
> +                           struct prune_option *prune_option)
> +{
> +       if (prune_option->prune != -1)
> +               argv_array_pushf(argv,
> +                                prune_option->prune
> +                                ? "--prune"
> +                                : "--no-prune");
> +}

Nit. I think argv_array_push() is enough for this case?
-- 
Duy
